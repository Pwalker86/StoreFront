module ApplicationHelper
  include Pagy::Frontend
  GSUB_OPTIONS = {
    product_reviews: "/product_reviews",
    store_reviews: "/store_reviews"
  }.freeze

  def pagy_url_for(pagy, page, absolute: false)
    params = request.query_parameters.merge(pagy.vars[:page_param] => page, only_path: !absolute)
    # for some reason, when creating a new review via turbo_frames, the url is generated such that it overrides the pagy links and makes them into normal links to a product review page. This just removes that.
    candidate = get_pagy_gsub_candidate(request.params[:controller].to_sym)
    url_for(params).gsub(candidate, "")
  end

  def get_pagy_gsub_candidate(candidate)
    GSUB_OPTIONS[candidate] || ""
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
