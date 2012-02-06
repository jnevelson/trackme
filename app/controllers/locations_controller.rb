class LocationsController < ApplicationController

  before_filter :ensure_params_exist

  def create
    if user = User.find_by_authentication_token(params[:auth_token])
      begin
        user.add_location(params)
        render_json(true, "Location posted!")
        return
      rescue => e
        render_json(false, e.message)
      end
    else
      render_json(false, "User not found!")
    end
  end

  protected

  def ensure_params_exist
    missing_params = ["auth_token", "latitude", "longitude"].select { |p| !params.keys.include?(p) }
    render_json(false, "Missing parameters: #{missing_params.join(", ")}") unless missing_params.empty?
  end

end
