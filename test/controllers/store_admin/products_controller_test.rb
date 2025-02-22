require "test_helper"

class StoreAdmin::ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @store_admin = store_admins(:store_admin_one)
    @store = stores(:store_one)
    @product = products(:product_one)
    sign_in @store_admin
  end

  test "should get index" do
    get store_admin_store_products_path(@store_admin, @store)
    assert_response :success
  end

   test "should show product" do
     get store_admin_store_product_path(@store_admin, @store, @product)
     assert_response :success
   end

  test "should get new" do
    get new_store_admin_store_product_path(@store_admin, @store)
    assert_response :success
  end

   test "should get edit" do
     get edit_store_admin_store_product_path(@store_admin, @store, @product)
     assert_response :success
   end

  test "should create product" do
    assert_difference("Product.count") do
      post store_admin_store_products_path(@store_admin, @store), params: { product: { name: "New Product", price: 10.0, description: "New Description" } }
    end
    assert_redirected_to store_admin_store_product_path(@store_admin, @store, Product.last)
  end

  test "should not create product with invalid params" do
    assert_no_difference("Product.count") do
      post store_admin_store_products_path(@store_admin, @store), params: { product: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should update product" do
    patch store_admin_store_product_path(@store_admin, @store, @product), params: { product: { name: "Updated Product" } }
    assert_redirected_to store_admin_store_products_path(@store_admin, @store)
  end

  test "should not update product with invalid params" do
    patch store_admin_store_product_path(@store_admin, @store, @product), params: { product: { name: "" } }
    assert_response :unprocessable_entity
  end
end
