class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  include Pundit::Authorization
  include Pagy::Backend
  helper_method :active_user
  before_action :ensure_cart, unless: :current_store_admin

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def active_user
    session[:guest_id] = nil and return if current_store_admin
    @active_user ||= if current_user
                     current_user
    elsif session[:guest_id]
                     Guest.find_or_create_by(id: session[:guest_id])
    else
                     guest = Guest.create!
                     session[:guest_id] = guest.id
                     guest
    end
  end

  # @return decorated [Cart]
  def ensure_cart
    @cart ||= CartDecorator.decorate(active_user.cart || active_user.create_cart!)
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(StoreAdmin)
      store_admin_store_path(resource, resource.store)
    else
      super
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
