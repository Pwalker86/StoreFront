module ApplicationHelper
  include Pagy::Frontend

  def pagy_url_for(pagy, page, absolute: false)
    params = request.query_parameters.merge(pagy.vars[:page_param] => page, only_path: !absolute)
    url_for(params)
  end

  def display_username
    if store_admin_signed_in?
      current_store_admin.email
    elsif user_signed_in?
      current_user.email
    else
      "Guest - Not logged in"
    end
  end

  def user_type
    if current_store_admin
      "store_admin"
    else
      "user"
    end
  end
end
