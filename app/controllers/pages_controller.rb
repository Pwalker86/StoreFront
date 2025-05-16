class PagesController < ApplicationController
  def home
    @stores = Store.cached_featured_stores
  end
end
