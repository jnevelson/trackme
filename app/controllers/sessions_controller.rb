class SessionsController < ApplicationController

  def create
    if user = User.find_for_database_authentication(:email => params[:email])
      if user.valid_password?(params[:password])
        sign_in("user", user)
        render :json => { :success => true, :auth_token => user.authentication_token }
        return
      end
    end
    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render_json(false, "Invalid login credentials!")
  end

end
