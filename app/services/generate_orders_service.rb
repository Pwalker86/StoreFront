
class GenerateOrdersService
  def initialize(store_admin_id)
    @store_admin = StoreAdmin.find(store_admin_id)
  end

  def generate
    begin
      store = @store_admin.store
      products = store.products.sample(3)
      user = User.last

      10.times do
        product_qty = rand(20)
        order = user.orders.new(
          orderable: @store_admin,
        )
        products.each do |product|
          order.order_items.new(
            price: product.price * product_qty, quantity: product_qty, product_id: product.id)
        end
        order.save!
      end
    rescue StandardError => e
      Rails.logger.error("Error generating orders: #{e.message}")
    end
  end
end
