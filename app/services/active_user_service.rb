class ActiveUserService
  def initialize(session, current_user, current_store_admin)
    @session = session
    @current_user = current_user
    @current_store_admin = current_store_admin
  end

  def call
    return nil if @current_store_admin

    if @current_user
      @current_user
    elsif @session[:guest_id]
      Guest.find_or_create_by(id: @session[:guest_id])
    else
      guest = Guest.create!
      guest.create_cart!
      @session[:guest_id] = guest.id
      guest
    end
  end
end
