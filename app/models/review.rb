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
#  user_id         :bigint           not null
#
# Indexes
#
#  index_reviews_on_reviewable  (reviewable_type,reviewable_id)
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  validates :title, :body, presence: true
  scope :ordered, -> { order(created_at: :desc) }

  # after_create_commit -> { broadcast_prepend_to "store_reviews", partial: "store_reviews/review", locals: { review: self }, target: "store_reviews" }
end
