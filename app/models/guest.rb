# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Guest < ApplicationRecord
  has_many :orders, as: :orderable
  has_one :cart, dependent: :destroy

  after_create_commit :create_guest_cart

  def display_name
    "Guest - Not Logged In"
  end

  def create_guest_cart
    if cart.nil?
      create_cart!
    end
  end
end
