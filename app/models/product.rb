class Product < ApplicationRecord
  belongs_to :store
  has_rich_text :description
  validates :name, presence: true
  validates :price, presence: true
end
