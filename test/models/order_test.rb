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
  fixtures :orders

  test "open?" do
    open_order = orders(:order_two)
    assert_equal true, open_order.open?
  end

  test "address1" do
    order = orders(:order_one)
    assert_equal "123 Main St", order.address1
  end
end
