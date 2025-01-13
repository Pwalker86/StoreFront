# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  archived     :boolean          default(FALSE)
#  description  :text
#  name         :string           not null
#  out_of_stock :boolean          default(FALSE)
#  price        :decimal(10, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  store_id     :bigint           not null
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by,
    against: :name,
    using: {
      tsearch: { prefix: true, any_word: true }
    }

  belongs_to :store
  has_many :reviews, as: :reviewable
  has_rich_text :description
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 250, nil ], preprocessed: true
  end

  ActsAsTaggableOn.delimiter = " "
  acts_as_taggable_on :tags

  validates :name, :price, presence: true
  validates_numericality_of :price, { greater_than_or_equal_to: 0 }
end
