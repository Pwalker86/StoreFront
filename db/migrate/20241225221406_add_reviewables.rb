class AddReviewables < ActiveRecord::Migration[8.0]
  def change
    add_reference :reviews, :reviewable, polymorphic: true, index: true
  end
end
