require "test_helper"

class CartUpdateServiceTest < ActiveSupport::TestCase
  def setup
    @session = {}
    @current_user = nil
    @current_store_admin = nil
  end

  test "returns {:updated, :message} on update" do
    @service = CartUpdateService.new("User", users(:user_one).id, products(:product_one).id, 1)
    obj = { status: :updated, message: "Quantity was successfully updated." }
    assert_equal obj, @service.call
  end

  test "returns {:removed, :message} on update" do
    @service = CartUpdateService.new("User", users(:user_one).id, products(:product_one).id, -1)
    obj = { status: :removed, message: "Product was successfully removed from your order." }
    assert_equal obj, @service.call
  end

  test "returns {:error, :message} with bad args" do
    @service = CartUpdateService.new("User", users(:user_one).id, "wefijoj", -1)
    obj = { status: :error, message: "There was an error updating the product quantity." }
    assert_equal obj, @service.call
  end

  test "returns {:error, :message} with bad args two" do
    @service = CartUpdateService.new("User", "oijojoj", products(:product_one), -1)
    obj = { status: :error, message: "There was an error updating the product quantity." }
    assert_equal obj, @service.call
  end

  test "returns {:error, :message} with bad args three" do
    @service = CartUpdateService.new("User", users(:user_one).id, "IJOIJIOJ", -1)
    obj = { status: :error, message: "There was an error updating the product quantity." }
    assert_equal obj, @service.call
  end
end
