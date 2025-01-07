class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  validates :title, :body, presence: true
  scope :ordered, -> { order(created_at: :desc) }

  # after_create_commit -> { broadcast_prepend_to "store_reviews", partial: "store_reviews/review", locals: { review: self }, target: "store_reviews" }
end
