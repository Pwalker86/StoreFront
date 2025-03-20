class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include Pundit::Authorization
  include Pagy::Backend
  helper_method :active_user
  before_action :active_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

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
