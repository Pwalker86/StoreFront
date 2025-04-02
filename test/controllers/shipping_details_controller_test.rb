require "test_helper"

class ShippingDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shipping_details_new_url
    assert_response :success
  end

  test "should get create" do
    get shipping_details_create_url
    assert_response :success
  end
end
