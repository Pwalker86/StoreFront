require "test_helper"

class StoreAdmin::OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = store_admins(:store_admin_one)
    @user = users(:user_one)
    @guest = guests(:guest_one)
    @order = orders(:order_one)
  end

  test "should redirect from INDEX when not authenticated" do
    sign_in @admin
    get orders_path
    assert_response :redirect
  end

  test "should get success INDEX when authenticated" do
    sign_in @user
    get orders_path
    assert_response :success
  end

  test "should get INDEX as a guest" do
    get orders_path
    assert_response :success
  end

  test "should redirect from SHOW when not authenticated" do
    sign_in @admin
    get order_path(@order)
    assert_response :redirect
  end

  test "should get success SHOW when authenticated" do
    sign_in @user
    get order_path(@order)
    assert_response :success
  end
end
