class StoreAdmin::OrdersController < ApplicationController
    before_action :authenticate_store_admin!

    def index
      @orders = current_store_admin.store_orders
      @store = Store.find(params[:store_id])
      authorize @store, policy_class: Admin::StorePolicy
    end

    def show
      order = Order.find(params[:id])
      @scoped_order_items = order.scoped_order_items(current_store_admin.store.id)
    end

    private

    def pundit_user
      current_store_admin
    end
end
