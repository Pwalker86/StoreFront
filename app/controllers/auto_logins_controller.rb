class AutoLoginsController < ApplicationController
  before_action :authenticate_resource, only: [:destroy]

  def create
    begin
      if current_user
        sign_out(current_user)
      elsif current_store_admin
        sign_out(current_store_admin)
      end

      resource_class = find_resource_class
      resource = resource_class.find_by(email: params[:email])

      if resource
        sign_in(resource)
        redirect_to after_sign_in_path_for(resource)
      else
        redirect_to after_sign_in_path_for(resource), alert: 'Invalid email or password' and return
      end
    rescue ActionController::RoutingError => e
      redirect_to root_path, notice: "Invalid resource type"
    end
  end

  def destroy
    sign_out(@resource)
    render json: { success: true, redirect_url: root_path }
  end

  private

  def resource_type
    params[:resource_type]&.downcase
  end

  def find_resource_class
    case resource_type
    when 'user'
      User
    when 'store_admin'
      StoreAdmin
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def authenticate_resource
    resource_class = find_resource_class
    @resource = resource_class.find(params[:id])

    unless @resource
      render json: { success: false, errors: ["Resource not found"] }, status: :not_found
    end
  end
end
