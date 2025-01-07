class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  validates :title, :body, presence: true
end
