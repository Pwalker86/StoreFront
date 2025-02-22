require "test_helper"

class StoreAdmin::StoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @new_store_admin = store_admins(:store_admin_none)
    @store_admin = store_admins(:store_admin_one)
    @store = stores(:store_one)
    sign_in @store_admin
  end

  test "set_store should redirect to root path if store not found" do
    get store_admin_store_path(@store_admin, 0)
    assert_redirected_to root_path
  end

  test "should get new" do
    sign_out @store_admin
    sign_in @new_store_admin
    get new_store_admin_store_path(@new_store_admin)
    assert_response :success
  end

  test "should get show when admin owns the store" do
    get store_admin_store_path(@store_admin, @store)
    assert_response :success
  end

  test "should get redirected when admin does not own the store" do
    store = stores(:store_two)
    get store_admin_store_path(@store_admin, store)
    assert_response :redirect
  end

  test "should be redirected when not a store admin" do
    sign_out @store_admin
    sign_in users(:user_one)
    get store_admin_store_path(@store_admin, @store)
    assert_response :redirect
  end

  test "should redirect on new if store already exists" do
    get new_store_admin_store_path(@store_admin)
    assert_response :redirect
  end

  test "should create store" do
    sign_out @store_admin
    sign_in @new_store_admin
    assert_difference("Store.count") do
      post store_admin_stores_path(@new_store_admin), params: { store: { name: "New Store", email: "new@store.com", phone_number: "1234567890", location: "New Location", mission_statement: "New Mission" } }
    end
    assert_redirected_to store_admin_store_path(@new_store_admin, Store.last)
  end

  test "should not create store with invalid params" do
    @new_store_admin = store_admins(:store_admin_none)
    sign_out @store_admin
    sign_in @new_store_admin
    post store_admin_stores_path(@new_store_admin), params: { store: { name: "", email: "", phone_number: "", location: "", mission_statement: "" } }
    assert_redirected_to new_store_admin_store_path(@new_store_admin)
  end

  test "should get edit" do
    get edit_store_admin_store_path(@store_admin, @store)
    assert_response :success
  end

  test "should update store" do
    patch store_admin_store_path(@store_admin, @store), params: { store: { name: "Updated Store" } }
    assert_redirected_to store_admin_store_path(@store_admin, @store)
  end

  test "should not update store with invalid params" do
    patch store_admin_store_path(@store_admin, @store), params: { store: { name: "" } }
    assert_response :unprocessable_entity
  end
end
