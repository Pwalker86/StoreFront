namespace :reviews do
  desc "Update existing orders to use polymorphic association"
  task update_user_id: :environment do
    Review.reset_column_information
    Review.find_each do | review |
      review.update(user_id: User.all.sample.id)
    end
  end
end
