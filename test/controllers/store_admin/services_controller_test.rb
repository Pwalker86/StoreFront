require "test_helper"

class StoreAdmin::ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_admin_services_index_url
    assert_response :success
  end

  test "should get show" do
    get store_admin_services_show_url
    assert_response :success
  end

  test "should get new" do
    get store_admin_services_new_url
    assert_response :success
  end

  test "should get create" do
    get store_admin_services_create_url
    assert_response :success
  end

  test "should get edit" do
    get store_admin_services_edit_url
    assert_response :success
  end

  test "should get update" do
    get store_admin_services_update_url
    assert_response :success
  end

  test "should get destroy" do
    get store_admin_services_destroy_url
    assert_response :success
  end
end
