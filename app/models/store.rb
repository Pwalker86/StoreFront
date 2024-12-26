class Store < ApplicationRecord
  belongs_to :store_admin
  has_many :reviews, as: :reviewable
  has_many :products
  has_many :orders
  has_one_attached :spotlight do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 300, 200 ]
  end
end
