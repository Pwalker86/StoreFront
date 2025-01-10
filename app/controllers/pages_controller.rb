class PagesController < ApplicationController
  def home
    @stores = StoreDecorator.decorate_collection Store.all
    # below are just for current dev purposes
    @users = User.all
    @admins = StoreAdmin.all
  end

  def products
    respond_to do |format|
      format.json { render json: Product.all }
    end
  end
end
