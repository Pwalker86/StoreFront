# == Schema Information
#
# Table name: services
#
#  id                :bigint           not null, primary key
#  description       :text
#  duration_in_hours :float
#  is_quote_needed   :boolean          default(FALSE)
#  name              :string           not null
#  rate_per_hour     :float
#  type              :string           default("StaticService"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_id          :bigint           not null
#
# Indexes
#
#  index_services_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class StaticService < Service
  validates :type, inclusion: { in: [ "StaticService" ] }
end
