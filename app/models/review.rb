# == Schema Information
#
# Table name: reviews
#
#  id              :bigint           not null, primary key
#  body            :text
#  rating          :float
#  reviewable_type :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  reviewable_id   :bigint
#
# Indexes
#
#  index_reviews_on_reviewable  (reviewable_type,reviewable_id)
#
class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  validates :title, :body, presence: true
  scope :ordered, -> { order(created_at: :desc) }

  # after_create_commit -> { broadcast_prepend_to "store_reviews", partial: "store_reviews/review", locals: { review: self }, target: "store_reviews" }
end
