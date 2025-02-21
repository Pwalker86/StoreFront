require "test_helper"

class StoreAdmin::StoreImagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect to root if store not found" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    get store_admin_store_store_image_url(admin, "oijoo", 1)
    assert_redirected_to root_url
    assert flash[:alert], "Store not found!"
  end

  test "should get SHOW" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    get store_admin_store_store_image_url(admin, store, 1)
    assert_response :success
  end

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

  test "should post create - SUCESS" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    post store_admin_store_store_images_url(admin, store), params: { store: { spotlight: fixture_file_upload("test_image.jpg", "image/jpg") } }
    assert store.spotlight.attached?
    assert_redirected_to edit_store_admin_store_url(admin, store)
    assert_equal flash[:notice], "Image was sucessfully uploaded!"
  end

  test "should post create - FAILURE" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    post store_admin_store_store_images_url(admin, store), params: { store: { spotlight: "wekjljlililnmnn123" } }
    assert_response :redirect
    # assert_equal flash[:notice], "Image was sucessfully uploaded!"
  end

  test "should get destroy" do
    admin = store_admins(:store_admin_one)
    sign_in admin
    store = stores(:store_one)
    delete store_admin_store_store_image_url(admin, store, 1)
    assert_response :redirect
  end

  test "should redirectif not store admin - SHOW" do
    user = users(:user_one)
    sign_in user
    store = stores(:store_one)
    get store_admin_store_store_image_url(user, store, 1)
    assert_response :redirect
    assert_equal flash[:alert], "You need to sign in or sign up before continuing."
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
