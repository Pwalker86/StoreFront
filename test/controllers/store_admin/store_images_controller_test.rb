require "test_helper"

class StoreImagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get new" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    get new_store_admin_store_store_image_url(admin, store)
    assert_response :success
  end

   test "should get edit" do
     admin = store_admins(:store_admin_one)
     sign_in admin
     store = stores(:store_one)
     get edit_store_admin_store_store_image_url(admin, store, 1)
     assert_response :success
   end

  test "should post create" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    post store_admin_store_store_images_url(admin, store), params: { store: { spotlight: fixture_file_upload("test_image.jpg", "image/jpg") } }
    assert store.spotlight.attached?
    assert_response :redirect
  end

  test "should get destroy" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    delete store_admin_store_store_image_url(admin, store, 1)
    assert_response :redirect
  end
end
