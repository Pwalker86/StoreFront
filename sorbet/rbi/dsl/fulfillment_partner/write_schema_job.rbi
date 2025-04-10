# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `FulfillmentPartner::WriteSchemaJob`.
# Please instead update this file by running `bin/tapioca dsl FulfillmentPartner::WriteSchemaJob`.


class FulfillmentPartner::WriteSchemaJob
  class << self
    sig { params(partner_id: T.untyped).returns(String) }
    def perform_async(partner_id); end

    sig { params(interval: T.any(DateTime, Time), partner_id: T.untyped).returns(String) }
    def perform_at(interval, partner_id); end

    sig { params(interval: Numeric, partner_id: T.untyped).returns(String) }
    def perform_in(interval, partner_id); end
  end
end
