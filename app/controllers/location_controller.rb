class LocationController < ApplicationController

  before_filter :validate_user

  def new
    raise "Must include longitude and latitude!" unless location_included?
    @user.post_location(params)
  end

  private

  def location_included?
    !!params[:longitude] && !!params[:latitude]
  end

  def validate_user
    @user = User.find_by_api_key(params[:api_key])
    raise "API key is not valid!" unless @user
  end

end
