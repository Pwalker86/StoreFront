module CartEnsurer
  extend ActiveSupport::Concern

  included do
    before_action :ensure_cart, unless: :current_store_admin
  end

  protected

  def ensure_cart
    @cart ||= CartDecorator.decorate(active_user.cart || active_user.create_cart!)
  end
end
