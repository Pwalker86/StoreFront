require "test_helper"

class Storeadmin::FulfillmentPartnersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get storeadmin_fulfillment_partners_show_url
    assert_response :success
  end

  test "should get new" do
    get storeadmin_fulfillment_partners_new_url
    assert_response :success
  end

  test "should get create" do
    get storeadmin_fulfillment_partners_create_url
    assert_response :success
  end

  test "should get edit" do
    get storeadmin_fulfillment_partners_edit_url
    assert_response :success
  end

  test "should get update" do
    get storeadmin_fulfillment_partners_update_url
    assert_response :success
  end

  test "should get destory" do
    get storeadmin_fulfillment_partners_destory_url
    assert_response :success
  end
end
