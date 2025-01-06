class Product < ApplicationRecord
  belongs_to :store
  has_many :reviews, as: :reviewable
  has_rich_text :description
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 250, nil ], preprocessed: true
  end

  validates :name, presence: true
  validates :price, presence: true
end
