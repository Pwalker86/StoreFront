class PagesController < ApplicationController
  def home
    @stores = StoreDecorator.decorate_collection Store.order("RANDOM()").limit(2)
  end
end
