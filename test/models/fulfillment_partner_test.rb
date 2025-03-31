# == Schema Information
#
# Table name: fulfillment_partners
#
#  id          :bigint           not null, primary key
#  email       :string
#  file_format :string           not null
#  file_schema :jsonb
#  location    :string
#  name        :string           not null
#  phone       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  store_id    :bigint
#
# Indexes
#
#  index_fulfillment_partners_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require "test_helper"

class FulfillmentPartnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
