class StoreAdmin::OrdersController < ApplicationController
    before_action :authenticate_store_admin!

    def index
      store = Store.find(params[:store_id])
      authorize store, policy_class: Admin::StorePolicy

      # Initial query to get all store orders
      orders_query = current_store_admin.store_orders

      # Handle sorting
      sort_column = params[:sort]
      sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"

      if sort_column.present?
        case sort_column
        when "id"
          @orders = orders_query.reorder("orders.id #{sort_direction}")
        when "status"
          @orders = orders_query.reorder("orders.status #{sort_direction}")
        when "created_at"
          @orders = orders_query.reorder("orders.created_at #{sort_direction}")
        when "last_export"
          # More complex sorting by join with last export date
          # This is a bit more complex and would require a subquery
          # For now just doing the simpler sorts
          @orders = orders_query
        else
          @orders = orders_query
        end
      else
        # Default sort by created_at desc if no sort specified
        @orders = orders_query
      end
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
