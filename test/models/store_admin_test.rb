# == Schema Information
#
# Table name: store_admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_store_admins_on_email                 (email) UNIQUE
#  index_store_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class StoreTest < ActiveSupport::TestCase
  test "store_orders" do
    order2 = orders(:order_two)
    admin = store_admins(:store_admin_one)
    assert_not_includes admin.store_orders, order2
  end
end
