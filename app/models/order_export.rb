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
class OrderExport < ApplicationRecord
  has_and_belongs_to_many :orders

  after_create :set_order_count

  private

  def set_order_count
    self.order_count = orders.count
    save
  end
end
