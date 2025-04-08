require "test_helper"

class ActiveUserServiceTest < ActiveSupport::TestCase
  def setup
    @session = {}
    @current_user = nil
    @current_store_admin = nil
    @service = ActiveUserService.new(@session, @current_user, @current_store_admin)
  end

  test "returns current_user when current_user is present" do
    @current_user = users(:user_one)
    @service = ActiveUserService.new(@session, @current_user, @current_store_admin)
    assert_equal @current_user, @service.call
  end

  test "returns guest when current_user is nil and session[:guest_id] is present" do
    @session[:guest_id] = guests(:guest_one).id
    @service = ActiveUserService.new(@session, @current_user, @current_store_admin)
    assert_equal guests(:guest_one), @service.call
  end

  test "returns guest when current_user is nil and session[:guest_id] is nil" do
    assert_difference "Guest.count", 1 do
      @service.call
      assert_not_nil @session[:guest_id]
    end
  end
end
