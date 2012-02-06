class LocationsController < ApplicationController

  before_filter :ensure_params_exist

  def create
    if user = User.find_by_authentication_token(params[:auth_token])
      begin
        user.add_location(params)
        render :json => { :success => true, :message => "Location posted!" }
        return
      rescue => e
        render_error(e.message)
      end
    else
      render_error("User not found!")
    end
  end

  protected

  def ensure_params_exist
    missing_params = [:auth_token, :latitude, :longitude].select { |p| !params.keys.include?(p) }
    return unless missing_params.blank?
    render :json => { :success => false, :message => "Missing parameters: #{missing_params.join(", ")}" }
  end

  def render_error(message)
    render :json => { :sucess => false, :message => message }
  end

end
