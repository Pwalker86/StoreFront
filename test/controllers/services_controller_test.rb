require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    store = stores(:store_one)
    get store_services_path(store)
    assert_response :success
  end

  test "should get show" do
    store = stores(:store_one)
    service = services(:service_one)
    get store_service_path(store, service)
    assert_response :success
  end
end
