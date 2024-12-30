class PagesController < ApplicationController
  def home
    @stores = StoreDecorator.decorate_collection Store.all
    # below are just for current dev purposes
    @users = User.all
    @admins = StoreAdmin.all
  end
end
