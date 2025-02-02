class PagesController < ApplicationController
  def home
    @stores = Store.joins(:spotlight_attachment).where.not(spotlight_attachment: { id: nil }).limit(12)
  end
end
