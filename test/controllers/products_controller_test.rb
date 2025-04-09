require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    store = stores(:store_one)
    get store_products_url(store)
    assert_response :success
    store.products.each do | product|
      assert_select "h3", { count: 1, text: product.name  }
    end
  end

  test "should get show" do
    product = products(:product_one)
    get store_product_url(stores(:store_one), product)
    assert_response :success
    assert_select "h1", {text:product.name,  count: 1 }
  end

  test "handles invalid product id" do
    get store_product_url(stores(:store_one), "invalid")
    assert_response :not_found
    assert_select "div", { text: "I'm sorry, that product doesn't exist!" }
  end
end
