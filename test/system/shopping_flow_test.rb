require "application_system_test_case"

class ShoppingFlowTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  # setup do
  #   @user = users(:user_one)
  #   @store = stores(:store_one)
  #   @product = products(:product_one)
  # end

  # test "user can log in, browse store, add item to cart, and view cart" do
  #   # Step 1: Log in as a user
  #   visit new_user_session_path
  #   fill_in "Email", with: @user.email
  #   fill_in "Password", with: "password123" # Assuming a standard password for fixtures
  #   click_button "Log in"

  #   assert_text "Signed in successfully"

  #   # Step 2: Visit the homepage and navigate to a store
  #   visit root_path
  #   assert_selector "h2", text: "Featured Stores"

  #   # Navigate to a store page
  #   visit store_path(@store)
  #   assert_selector "h1", text: @store.name

  #   # Step 3: View a product and add it to the cart
  #   # First make sure the products are loaded
  #   assert_selector "turbo_frame#store_products"

  #   # Navigate to product page
  #   visit store_product_path(@store, @product)
  #   assert_selector "h1", text: @product.name

  #   # Add to cart
  #   click_button "Add to Cart"
  #   assert_text "Item added to cart"

  #   # Step 4: View the cart
  #   click_link "Cart" # Assuming there's a cart link in the navigation

  #   # Verify we're on the cart page
  #   assert_selector "h1", text: "#{@user.email}'s Cart"

  #   # Verify the product is in the cart
  #   assert_text @product.name
  #   assert_text @product.price.to_s

  #   # Verify checkout button is present
  #   assert_link "Proceed to Checkout"
  # end
end
