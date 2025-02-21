require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get SHOW" do
    store = stores(:store_one)
    get store_url(store)
    assert_response :success
  end

  test "should redirect to root if store not found" do
    get store_url("hello")
    assert_redirected_to root_url
    assert flash[:alert], "Store not found!"
  end
end
