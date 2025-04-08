class PopulateOrdersService
  def initialize
  end

  def call
    begin
      User.in_batches(of: 100) do |users|
        users.each do |user|
          generate_orders_for_user(user)
        end
      end
      Order.in_batches(of: 100) do |orders|
        orders.each do |order|
          generate_order_items(order)
        end
      end

    rescue ActiveRecord::RecordInvalid => e
      puts "Error creating orders: #{e.message}"
    end
  end

  private

  def generate_orders_for_user(user)
    begin
      rand(1..10).times do
        Order.create!(
          orderable: user,
          full_name: Faker::Name.name,
          email: Faker::Internet.email,
          address1: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state,
          postal_code: Faker::Address.zip_code,
          status: Order::ORDER_PENDING,
        )
      end
    rescue ActiveRecord::RecordInvalid => e
      puts "Error creating order for user #{user.id}: #{e.message}"
    end
  end

  def generate_order_items(order)
    begin
      rand(1..5).times do
        product = Product.order("RANDOM()").first
        quantity = rand(1..10)
        OrderItem.create!(
          order: order,
          product: product,
          price: product.price * quantity,
          quantity: quantity
        )
      end
    rescue ActiveRecord::RecordInvalid => e
      puts "Error creating order items for order #{order.id}: #{e.message}"
    end
  end
end

# Usage:
# service = PopulateOrdersService.new(user_id)
# service.call
