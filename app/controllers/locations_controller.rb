class LocationsController < ApplicationController

  before_filter :initialize_errors, :validate_user

  def create
    if @user
      begin
        @user.add_location(params)
      rescue => e
        @errors << e.message
      end
    end
    status = @errors.empty? ? "Location posted!\n" : "Error posting location: #{@errors}\n"
    render :text => status
  end

  private

  def validate_user
    @user = User.find_by_authentication_token(params[:auth_token])
    @errors << "Authentication token is not valid!" unless @user
  end

  def initialize_errors
    @errors = []
  end

end
