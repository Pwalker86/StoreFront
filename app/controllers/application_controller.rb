class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include Pundit::Authorization
  include Pagy::Backend
  before_action :set_auto_login_users
  helper_method :active_user
  before_action :active_user
  before_action :enforce_route_authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  # Enforces high-level route authorization:
  # - If user is a StoreAdmin, they can only access /store_admin routes
  # - If user is NOT a StoreAdmin, they cannot access /store_admin routes
  def enforce_route_authorization
    path = request.path
    is_store_admin_route = path.start_with?("/store_admin")
    is_store_admin = current_store_admin.present?

    # Skip enforcement for devise routes to prevent login issues
    return if path.start_with?("/users/sign_") || path.start_with?("/store_admins/sign_") || path.start_with?("/auto_logins")

    if is_store_admin && !is_store_admin_route && !request.xhr?
      # Redirect StoreAdmin to their store page if trying to access non-admin routes
      store = current_store_admin.store
      redirect_path = store ? store_admin_store_path(current_store_admin, store) : new_store_admin_store_path(current_store_admin)
      redirect_to redirect_path, alert: "As a store admin, you can only access admin pages."
    elsif !is_store_admin && is_store_admin_route
      # Redirect non-StoreAdmin users to root if trying to access admin routes
      redirect_to root_path, alert: "You don't have permission to access that page."
    end
  end

  def set_auto_login_users
    @auto_login_user = User.first if User.first.present?
    @auto_login_admin = StoreAdmin.first if StoreAdmin.first.present?
  end

  def active_user
    @active_user ||= ActiveUserService.new(session, current_user, current_store_admin).call
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(StoreAdmin)
      store_admin_store_or_new_path(resource)
    else
      super
    end
  end

  def store_admin_store_or_new_path(store_admin)
    if store_admin.store.present?
      store_admin_store_path(store_admin, store_admin.store)
    else
      new_store_admin_store_path(store_admin)
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
