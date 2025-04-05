# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  email        :string
#  first_name   :string
#  instructions :text
#  last_name    :string
#  state        :string
#  zip_code     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :bigint           not null
#
# Indexes
#
#  index_customers_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
