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
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:product_one)
  end

  test "should be valid" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.name = "   "
    assert_not @product.valid?
  end

  test "price should be present" do
    @product.price = nil
    assert_not @product.valid?
  end

  test "price should be a number" do
    @product.price = "not_a_number"
    assert_not @product.valid?
  end

  test "price should be greater than or equal to 0" do
    @product.price = -1
    assert_not @product.valid?
  end

  test "should belong to store" do
    assert_equal stores(:store_one), @product.store
  end

  test "should have many reviews" do
    assert_respond_to @product, :reviews
  end

  test "should have rich text description" do
    assert_respond_to @product, :description
  end

  test "should have many attached images" do
    assert_respond_to @product, :images
  end

  test "archived should be false by default" do
    new_product = Product.new
    assert_not new_product.archived
  end

  test "out_of_stock should be false by default" do
    new_product = Product.new
    assert_not new_product.out_of_stock
  end
end
