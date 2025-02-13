require "test_helper"

class StoreAdmin::StoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show when admin owns the store" do
    sign_in store_admins(:store_admin_one)
    store = stores(:store_one)
    get store_admin_store_path(store_admins(:store_admin_one), store)
    assert_response :success
  end

  test "should get redirected when admin does not own the store" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_two)
    get store_admin_store_path(admin, store)
    assert_response :redirect
  end

  test "should be redirected when not a store admin" do
    sign_in users(:user_one)
    admin = store_admins(:store_admin_one)
    store = stores(:store_one)
    get store_admin_store_path(admin, store)
    assert_response :redirect
  end
end
