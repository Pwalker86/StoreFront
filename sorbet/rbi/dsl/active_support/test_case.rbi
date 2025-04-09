# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ActiveSupport::TestCase`.
# Please instead update this file by running `bin/tapioca dsl ActiveSupport::TestCase`.


class ActiveSupport::TestCase
  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[ActionText::RichText]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(ActionText::RichText) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[ActionText::RichText])
  end
  def action_text_rich_texts(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[CartItem]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(CartItem) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[CartItem])
  end
  def cart_items(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Cart]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Cart) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Cart]) }
  def carts(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[FulfillmentPartner]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(FulfillmentPartner) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[FulfillmentPartner])
  end
  def fulfillment_partners(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Guest]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Guest) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Guest]) }
  def guests(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[OrderExport]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(OrderExport) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[OrderExport])
  end
  def order_exports(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[OrderItem]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(OrderItem) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[OrderItem])
  end
  def order_items(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Order]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Order) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Order]) }
  def orders(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Product]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Product) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Product]) }
  def products(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Review]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Review) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Review]) }
  def reviews(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[ShippingDetailsImport]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(ShippingDetailsImport) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[ShippingDetailsImport])
  end
  def shipping_details_imports(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[StoreAdmin]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(StoreAdmin) }
  sig do
    params(
      fixture_name: T.any(String, Symbol),
      other_fixtures: T.any(String, Symbol)
    ).returns(T::Array[StoreAdmin])
  end
  def store_admins(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[Store]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(Store) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[Store]) }
  def stores(fixture_name = nil, *other_fixtures); end

  sig { params(fixture_name: NilClass, other_fixtures: NilClass).returns(T::Array[User]) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: NilClass).returns(User) }
  sig { params(fixture_name: T.any(String, Symbol), other_fixtures: T.any(String, Symbol)).returns(T::Array[User]) }
  def users(fixture_name = nil, *other_fixtures); end
end
