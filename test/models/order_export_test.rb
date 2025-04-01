# == Schema Information
#
# Table name: order_exports
#
#  id               :bigint           not null, primary key
#  date_exported_at :datetime
#  order_count      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class OrderExportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
