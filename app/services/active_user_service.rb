class ActiveUserService
  def initialize(session:, current_user:, current_store_admin:)
    @session = session
    @current_user = current_user
    @current_store_admin = current_store_admin
  end

  def call
    return nil if @current_store_admin # No active user if a StoreAdmin is present
    return @current_user if @current_user

    if @session[:guest_id]
      Guest.find_by(id: @session[:guest_id])
    else
      create_guest
    end
  end

  private

  def create_guest
    guest = Guest.create!
    @session[:guest_id] = guest.id
    guest
  end
end
