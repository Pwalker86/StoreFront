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

  test "should create an order from a cart as USER" do
    sign_in @user
    post orders_path, params: { order: { user_entity: "User", user_entity_id: @user.id, address1: "123 Main St", address2: "", city: "Springfield", state: "IL", postal_code: "62701", email: @user.email } }
    assert_redirected_to orders_path
  end

  test "should create an order from a cart as GUEST" do
    post orders_path, params: { order: { user_entity: "Guest", user_entity_id: @guest.id, address1: "123 Main St", address2: "", city: "Springfield", state: "IL", postal_code: "62701", email: "guest@email.com" } }
    assert_redirected_to root_path
  end

  test "should redirect from CREATE when an error occurs" do
    sign_in @user
    post orders_path, params: { order: { user_entity: "Unknown", user_entity_id: @user.id, address1: "123 Main St", address2: "", city: "Springfield", state: "IL", postal_code: "62701", email: @user.email } }
    assert_redirected_to root_path
  end
end
