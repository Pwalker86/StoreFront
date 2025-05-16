require "test_helper"

class StoreAdmin::ServicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @store_admin = store_admins(:store_admin_one)
    @service = services(:service_one)
  end

  test "should get index" do
    sign_in @store_admin
    get store_admin_store_services_path(@store_admin, @store_admin.store)
    assert_response :success
  end

  test "should get show" do
    sign_in @store_admin
    get store_admin_store_service_path(@store_admin, @store_admin.store, @service)
    assert_response :success
  end

   test "should get new" do
     sign_in @store_admin
     get new_store_admin_store_service_path(@store_admin, @store_admin.store)
     assert_response :success
   end

  test "should get create" do
    sign_in @store_admin
    assert_difference("Service.count") do
      post store_admin_store_services_path(@store_admin, @store_admin.store), params: { service: { name: "New Service", description: "a new service description", duration_in_hours: "0.5", type: "StaticService", rate_per_hour: "55" } }
    end
    assert_response :redirect
  end

  test "should get edit" do
     sign_in @store_admin
     get edit_store_admin_store_service_path(@store_admin, @store_admin.store, @service)
     assert_response :success
  end
  #
  test "should get update" do
    sign_in @store_admin
    put store_admin_store_service_path(@store_admin, @store_admin.store, @service), params: { service: { name: "Updated Service", description: "an updated service description", duration_in_hours: "0.5", type: "StaticService", rate_per_hour: "55" } }
    s = Service.find @service.id
    assert s.name, "Updated Service"
    assert_response :redirect
  end

   test "should get destroy" do
     sign_in @store_admin
     assert_difference("Service.count", -1) do
       delete store_admin_store_service_path(@store_admin, @store_admin.store, @service)
     end
     assert_response :redirect
   end
end
