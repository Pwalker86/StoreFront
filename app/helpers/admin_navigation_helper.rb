module AdminNavigationHelper
  def admin_navigation_links
    return [] unless current_store_admin

    links = []
    links << {name: "Import Shipping Details", path: new_store_admin_shipping_detail_path(current_store_admin)}

    if store_exists?
      links << {name: "View Store", path: store_admin_store_path(current_store_admin, current_store_admin.store)}
      links << {name: "Edit Store", path: edit_store_admin_store_path(current_store_admin, current_store_admin.store)}
      links << {name: "View All Orders", path: store_admin_store_orders_path(current_store_admin, current_store_admin.store)}

      # Fulfillment partner links
      if current_store_admin.store.fulfillment_partner.present?
        links << {name: "Fulfillment Partners", path: store_admin_store_fulfillment_partner_path(
          current_store_admin, current_store_admin.store, current_store_admin.store.fulfillment_partner)}
      else
        links << {name: "Create Fulfillment Partner", path: new_store_admin_store_fulfillment_partner_path(
          current_store_admin, current_store_admin.store)}
      end
    else
      links << {name: "Create Store", path: new_store_admin_store_path(current_store_admin)}
    end

    links
  end

  def store_exists?
    current_store_admin&.store&.persisted?
  end

  def admin_home_link
    return unless store_exists?
    {
      path: store_admin_store_path(current_store_admin, current_store_admin.store),
      icon: "fa-brands fa-forumbee",
      title: "MarketHive"
    }
  end
end
