class LocationsController < ApplicationController

  def create
    if user = User.find_by_authentication_token(params[:auth_token])
      begin
        user.add_location(params)
        render_json(true, "Location posted!")
      rescue => e
        render_json(false, e.message)
      end
    else
      render_json(false, "Invalid auth_token")
    end
  end

end
