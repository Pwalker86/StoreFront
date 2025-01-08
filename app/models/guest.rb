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
  has_one :cart

  def email
    "Guest - Not logged in"
  end
end
