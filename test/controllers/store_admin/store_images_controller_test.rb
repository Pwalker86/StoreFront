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

  test "should redirect if not store admin - NEW" do
    user = users(:user_one)
    sign_in user
    store = stores(:store_one)
    get new_store_admin_store_store_image_url(user, store)
    assert_response :redirect
  end

  test "should redirect if not store admin - EDIT" do
    user = users(:user_one)
    sign_in user
    store = stores(:store_one)
    get edit_store_admin_store_store_image_url(user, store, 1)
    assert_response :redirect
  end

  test "should redirect if not store admin - CREATE" do
    user = users(:user_one)
    sign_in user
    store = stores(:store_one)
    post store_admin_store_store_images_url(user, store), params: { store: { spotlight: fixture_file_upload("test_image.jpg", "image/jpg") } }
    assert_response :redirect
    assert_not store.spotlight.attached?
  end

  test "should redirect if not store admin - DESTROY" do
    user = users(:user_one)
    sign_in user
    store = stores(:store_one)
    delete store_admin_store_store_image_url(user, store, 1)
    assert_response :redirect
  end
end
