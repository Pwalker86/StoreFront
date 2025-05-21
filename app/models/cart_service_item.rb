class CartServiceItem < ApplicationRecord
  belongs_to :cart
  belongs_to :service
end
