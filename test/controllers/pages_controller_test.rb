require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_url
    assert_response :success
    assert_select ".StoreCard", { count: 0 }
  end

  test "should get root_url" do
    get root_url
    assert_response :success
    assert_select "h1", { count: 1, text:"Discover Amazing Stores"  }
  end
end
