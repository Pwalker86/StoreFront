require 'test_helper'

class AutoLoginsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one) # Assuming you have fixtures set up
    @store_admin = store_admins(:store_admin_one) # Assuming you have fixtures set up
  end

  test "should login user with correct credentials" do
    post auto_logins_path('user'), params: { email: @user.email }
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "should login store admin with correct credentials" do
    post auto_logins_path('store_admin'), params: { email: @store_admin.email }
    assert_response :redirect
    assert_redirected_to store_admin_store_path(@store_admin, @store_admin.store)
  end

  test "should not login with invalid resource type" do
    post auto_logins_path('invalid_type'), params: { email: @user.email }
    assert_response :redirect
    assert_redirected_to root_path
    assert flash[:notice], "Invalid resource type"
  end

  test "should sign out user" do
    sign_in @user
    delete auto_login_path('user', @user.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response['success']
    assert_equal root_path, json_response['redirect_url']
  end

  test "should sign out store admin" do
    sign_in @store_admin
    delete auto_login_path('store_admin', @store_admin.id)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response['success']
    assert_equal root_path, json_response['redirect_url']
  end
end
