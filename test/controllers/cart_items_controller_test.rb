# require "test_helper"
#
# class StoreReviewsControllerTest < ActionDispatch::IntegrationTest
#   include Devise::Test::IntegrationHelpers
#
#   setup do
#     @user = users(:user_one)
#     @store = stores(:store_one)
#     @product = products(:product_one)
#     sign_in @user
#   end
#
#   test "should get index" do
#     get store_store_reviews_path(@store)
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_store_store_review_path(@store)
#     assert_response :success
#     assert_select "form[action=?]", store_store_reviews_path(@store)
#   end
#
#   test "should get edit" do
#     get edit_store_store_review_path(@store, reviews(:store_review))
#     assert_select "form[action=?]", store_store_review_path(@store, reviews(:store_review))
#     assert_select "textarea", { text: reviews(:store_review).body, count: 1 }
#   end
#
#   test "should update review" do
#     patch store_store_review_path(@store, reviews(:store_review)), params: { review: { title: "Updated Title", body: "Updated Body" } }
#     assert_redirected_to store_path(@store)
#   end
#
#   test "should not update review with invalid params" do
#     patch store_store_review_path(@store, reviews(:store_review)), params: { review: { title: "", body: "" } }
#     assert_response :unprocessable_entity
#   end
#
#   test "should create review" do
#     assert_difference("Review.count") do
#       post store_store_reviews_path(@store), params: { review: { title: "New Title", body: "New Body" } }
#     end
#     assert_redirected_to store_path(@store)
#   end
#
#   test "should not create review with invalid params" do
#     assert_no_difference("Review.count") do
#       post store_store_reviews_path(@store), params: { review: { title: "", body: "" } }
#     end
#     assert_response :unprocessable_entity
#   end
#
#   test "should destroy review" do
#     assert_difference("Review.count", -1) do
#       delete store_store_review_path(@store, reviews(:store_review))
#     end
#     assert_redirected_to store_path(@store)
#   end
# end
