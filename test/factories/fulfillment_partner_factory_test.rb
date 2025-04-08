require "test_helper"

class FulfillmentPartnerFactoryTest < ActiveSupport::TestCase
  setup do
    @csv_partner_params = {
      name: "Test CSV Partner",
      location: "Test Location",
      email: "test@example.com",
      phone: "555-1234",
      store_id: stores(:store_one).id,
      csv_headers: { "email" => "true", "full_name" => "true", "address1" => "false" },
      type: 'CsvPartner'
    }

    @json_partner_params = {
      name: "Test JSON Partner",
      location: "Test Location",
      email: "test@example.com",
      phone: "555-1234",
      store_id: stores(:store_one).id,
      type: 'JsonPartner'
    }
  end

  test "creates a CsvPartner with filtered headers" do
    partner = FulfillmentPartnerFactory.create_fulfillment_partner("CsvPartner", @csv_partner_params)

    assert_instance_of CsvPartner, partner
    assert_equal ["email", "full_name"], partner.csv_headers
    assert_equal "Test CSV Partner", partner.name
    assert_equal "Test Location", partner.location
  end

  test "creates a JsonPartner" do
    partner = FulfillmentPartnerFactory.create_fulfillment_partner("JsonPartner", @json_partner_params)

    assert_instance_of JsonPartner, partner
    assert_equal "Test JSON Partner", partner.name
    assert_equal "Test Location", partner.location
  end

  test "raises error for unknown partner type" do
    assert_raises(FulfillmentPartnerFactory::UnknownFulfillmentPartnerTypeError) do
      FulfillmentPartnerFactory.create_fulfillment_partner("UnknownPartner", @csv_partner_params)
    end
  end

  test "updates from CsvPartner to JsonPartner" do
    original_partner = fulfillment_partners(:csv_partner)
    updated_partner = FulfillmentPartnerFactory.update_fulfillment_partner(
      original_partner,
      "JsonPartner",
      @json_partner_params
    )

    assert_instance_of JsonPartner, updated_partner
    assert_equal "JsonPartner", updated_partner.type
    assert_equal [], updated_partner.csv_headers
    assert_equal @json_partner_params[:name], updated_partner.name
  end

  test "updates from JsonPartner to CsvPartner" do
    original_partner = fulfillment_partners(:json_partner)
    updated_partner = FulfillmentPartnerFactory.update_fulfillment_partner(
      original_partner,
      "CsvPartner",
      @csv_partner_params
    )

    assert_instance_of CsvPartner, updated_partner
    assert_equal "CsvPartner", updated_partner.type
    assert_equal ["email", "full_name"], updated_partner.csv_headers
    assert_nil updated_partner.file_schema
    assert_equal @csv_partner_params[:name], updated_partner.name
  end

  test "raises error when updating to unknown partner type" do
    original_partner = fulfillment_partners(:csv_partner)

    assert_raises(FulfillmentPartnerFactory::UnknownFulfillmentPartnerTypeError) do
      FulfillmentPartnerFactory.update_fulfillment_partner(original_partner, "UnknownPartner", @csv_partner_params)
    end
  end

  test "filter_csv_headers selects only true values" do
    headers = {
      "email" => "true",
      "full_name" => "true",
      "address1" => "false",
      "city" => "true",
      "postal_code" => "false"
    }

    filtered = FulfillmentPartnerFactory.filter_csv_headers(headers)

    assert_equal ["email", "full_name", "city"], filtered
    assert_not_includes filtered, "address1"
    assert_not_includes filtered, "postal_code"
  end

  test "filter_csv_headers handles nil input" do
    assert_raises(FulfillmentPartnerFactory::NilHeadersError) do
      FulfillmentPartnerFactory.filter_csv_headers(nil)
    end
  end

  test "filter_csv_headers handles empty input" do
    assert_empty FulfillmentPartnerFactory.filter_csv_headers({})
  end
end
