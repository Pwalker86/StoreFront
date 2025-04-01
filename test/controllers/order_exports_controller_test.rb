require "test_helper"

class OrderExportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_exports_index_url
    assert_response :success
  end

  test "should get show" do
    get order_exports_show_url
    assert_response :success
  end

  test "should get create" do
    get order_exports_create_url
    assert_response :success
  end
end
