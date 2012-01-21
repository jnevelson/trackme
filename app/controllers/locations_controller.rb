class LocationsController < ApplicationController

  before_filter :initialize_errors, :validate_user

  def create
    if @user
      begin
        @user.post_location(params)
      rescue => e
        @errors << e.message
      end
    end
    status = @errors.empty? ? "Location posted!\n" : "Error posting location: #{@errors}"
    render :text => status
  end

  private

  def location_included?
    !!params[:longitude] && !!params[:latitude]
  end

  def validate_user
    @user = User.find_by_api_key(params[:api_key])
    @errors << "API key is not valid!" unless @user
  end

  def initialize_errors
    @errors = []
  end

end
