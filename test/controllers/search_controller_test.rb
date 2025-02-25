require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index - HTML" do
    get search_index_url, params: { query: "Potter" }
    assert_response :success
  end

  test "should get index - JSON" do
    get search_index_url, params: { query: "Potter" }, as: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "Harry Potter", body[0]["name"]
  end
end
