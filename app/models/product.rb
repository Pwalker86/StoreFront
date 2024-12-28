class Product < ApplicationRecord
  belongs_to :store
  has_many :reviews, as: :reviewable
  has_rich_text :description
  validates :name, :price, :description, presence: true
end
