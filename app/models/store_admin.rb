# == Schema Information
#
# Table name: store_admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_store_admins_on_email                 (email) UNIQUE
#  index_store_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
class StoreAdmin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one :store

  def store_orders
    Order.joins(order_items: { product: :store }).where(stores: { store_admin_id: id }).distinct
  end
end
