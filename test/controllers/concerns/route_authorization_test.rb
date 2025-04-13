require "test_helper"

class RouteAuthorizationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @store_admin = store_admins(:store_admin_one)
    @user = users(:user_one)
    @store = stores(:store_one)
  end

  test "store admin cannot access regular user routes" do
    sign_in @store_admin
    get root_path
    assert_response :redirect
    assert_redirected_to store_admin_store_path(@store_admin, @store)
    assert_equal "As a store admin, you can only access admin pages.", flash[:alert]
  end

  test "non-admin users cannot access store admin routes" do
    sign_in @user
    get store_admin_store_path(@store_admin, @store)
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal "You don't have permission to access that page.", flash[:alert]
  end

  test "unauthenticated users cannot access store admin routes" do
    get store_admin_store_path(@store_admin, @store)
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal "You don't have permission to access that page.", flash[:alert]
  end

  test "store admins can access store admin routes" do
    sign_in @store_admin
    get store_admin_store_path(@store_admin, @store)
    assert_response :success
  end

  test "regular users can access regular routes" do
    sign_in @user
    get root_path
    assert_response :success
  end

  test "sign in routes are accessible to everyone" do
    get new_user_session_path
    assert_response :success

    get new_store_admin_session_path
    assert_response :success
  end
end
