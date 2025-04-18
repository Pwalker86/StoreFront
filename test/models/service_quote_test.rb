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
#  services_id    :bigint           not null
#
# Indexes
#
#  index_service_quotes_on_services_id  (services_id)
#
# Foreign Keys
#
#  fk_rails_...  (services_id => services.id)
#
require "test_helper"

class ServiceQuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
