require 'rake'
Rails.application.load_tasks

class AddUserToReviews < ActiveRecord::Migration[8.0]
  def change
    add_reference :reviews, :user, foreign_key: true

    # Invoke the rake task after the schema change
    reversible do |dir|
      dir.up do
        Rake::Task['reviews:update_user_id'].invoke
      end
    end
  end
end
