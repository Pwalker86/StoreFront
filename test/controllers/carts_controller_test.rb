require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    @guest = guests(:guest_one)
    sign_in @user
  end

   test "should get show as a user" do
     get user_cart_path(@user)
     assert_response :success
     assert_select "h1", { text: "#{@user.email}'s Cart", count: 1 }
   end

   test "should get show as a guest" do
     sign_out @user
     get user_cart_path(@guest)
     assert_response :success
     assert_select "h1", { text: "Guest's Cart", count: 1 }
   end

   test "should get the right cart, even when passing the wrong user id" do
     get user_cart_path(users(:user_two))
     assert_response :success
     assert_select "h1", { text: "#{@user.email}'s Cart", count: 1 }
   end

   test "should update the cart" do
     patch user_cart_path(@user), params: { user_entity: "User", user_id: @user.id, product_id: products(:product_one).id, quantity: 1 }
     assert_redirected_to user_cart_path(@user)
     assert flash[:notice], "Quantity was successfully updated."
   end

  test "should redirect with bad params" do
    patch user_cart_path(@user), params: { user_entity: "User", user_id: @user.id, product_id: "joijio", quantity: 1 }
    assert_redirected_to user_cart_path(@user)
    assert flash[:alert], "There was an error updating the product quantity."
  end
end
