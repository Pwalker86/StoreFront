class Store < ApplicationRecord
  belongs_to :store_admin
  has_many :reviews, as: :reviewable
  has_many :products
  has_many :orders
  has_one_attached :spotlight do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 300, 300 ]
  end

  after_commit :add_default_spotlight, on: [ :create, :update ]

  private
  def add_default_spotlight
    unless spotlight.attached?
      self.spotlight.attach(io: File.open(Rails.root.join("app", "assets", "images", "placeholder.png")), filename: "placholder.png", content_type: "image/png")
    end
  end
end
