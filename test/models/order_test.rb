# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  email            :string
#  orderable_type   :string
#  shipping_address :jsonb
#  status           :string           default("pending")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  orderable_id     :bigint
#
# Indexes
#
#  index_orders_on_orderable  (orderable_type,orderable_id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:order_one)
  end

  test "open?" do
    order = orders(:open_order)
    assert_equal true, order.open?
  end

  test "address1" do
    assert_equal "123 Main St", @order.address1
  end

  test "address2" do
    assert_equal "Apt 1", @order.address2
  end

  test "city" do
    assert_equal "Anytown", @order.city
  end

  test "state" do
    assert_equal "NY", @order.state
  end

  test "postal_code" do
    assert_equal "12345", @order.postal_code
  end

  test "destroy raises an error" do
    assert_raises ActiveRecord::DeleteRestrictionError do
      @order.destroy
    end
  end
end
