class Store < ApplicationRecord
  belongs_to :store_admin
  has_many :products
  has_many :orders
  has_one_attached :spotlight do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end
end
