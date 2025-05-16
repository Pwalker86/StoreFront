# == Schema Information
#
# Table name: service_quotes
#
#  id             :bigint           not null, primary key
#  contact_email  :string
#  contact_number :string
#  customer_name  :string
#  details        :text
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  service_id     :bigint           not null
#
# Indexes
#
#  index_service_quotes_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_...  (service_id => services.id)
#
require "test_helper"

class ServiceQuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
