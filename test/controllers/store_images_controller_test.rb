require "test_helper"

class StoreImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get store_images_new_url
    assert_response :success
  end

  test "should get create" do
    get store_images_create_url
    assert_response :success
  end

  test "should get edit" do
    get store_images_edit_url
    assert_response :success
  end

  test "should get update" do
    get store_images_update_url
    assert_response :success
  end

  test "should get destroy" do
    get store_images_destroy_url
    assert_response :success
  end
end
