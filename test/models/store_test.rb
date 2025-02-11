# == Schema Information
#
# Table name: stores
#
#  id                :bigint           not null, primary key
#  email             :string
#  location          :string
#  mission_statement :string
#  name              :string           not null
#  phone_number      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_admin_id    :bigint
#
# Indexes
#
#  index_stores_on_store_admin_id  (store_admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_admin_id => store_admins.id)
#
require "test_helper"

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = stores(:store_one)
  end

  test "name should be present" do
    @store.name = "   "
    assert_not @store.valid?
    @store.name = "Store1"
    assert @store.valid?
  end

  test "email should be present" do
    @store.email=nil
    assert_not @store.valid?
    @store.email = "store1@email.com"
    assert @store.valid?
  end

  test "invalid email is invalid" do
    @store.email = "1"
    assert_not @store.valid?
  end

  test "location should be present" do
    @store.location=nil
    assert_not @store.valid?
    @store.location = "Utah, US"
    assert @store.valid?
  end

  test "should have a phone number" do
    @store.phone_number=nil
    assert_not @store.valid?
    @store.phone_number = "8015551234"
    assert @store.valid?
  end

  test "should have a store admin" do
    assert_equal store_admins(:store_admin_one), @store.store_admin
  end

  test "should have a review" do
    assert_equal @store.reviews.first, reviews(:store_review)
  end

  # NOTE: Not needed as I've removed the after save callback for now. Instead will implement a prompt notifying the user that their store cannot be featured if they don't attached a photo
  # test "a spotlight is attached if there's not already one" do
  #   assert_not @store.spotlight.attached?
  #   @store.save
  #   assert @store.spotlight.attached?
  # end
end
