class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_user
  before_action :ensure_cart
  protect_from_forgery with: :exception, prepend: true


  protected

  def set_active_user
    session[:guest_id] = nil and return if current_admin
    if current_user
      @active_user = current_user
    elsif current_user.nil? && session[:guest_id]
      @active_user = Guest.find_or_create_by(id: session[:guest_id])
    elsif current_user.nil?
      @active_user = Guest.create!
      session[:guest_id] = @active_user.id
    end
  end

  # @return decorated [Cart]
  def ensure_cart
    return if current_admin
    set_active_user if !@active_user
    cart = @active_user.cart || @active_user.create_cart!
    @cart = CartDecorator.decorate(cart)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
