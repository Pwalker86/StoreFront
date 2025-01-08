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
class Store < ApplicationRecord
  belongs_to :store_admin
  has_many :reviews, as: :reviewable
  has_many :products
  has_many :orders
  has_one_attached :spotlight do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 250, nil ], preprocessed: true
  end

  after_commit :add_default_spotlight, on: [ :create, :update ]

  validates :name, :phone_number, :location, :email, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  private
  def add_default_spotlight
    unless spotlight.attached?
      self.spotlight.attach(io: File.open(Rails.root.join("app", "assets", "images", "placeholder.png")), filename: "placholder.png", content_type: "image/png")
    end
  end
end
