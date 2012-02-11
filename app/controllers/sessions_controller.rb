class SessionsController < ApplicationController

  before_filter :ensure_params_exist

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

  def ensure_params_exist
    return unless params[:email].blank? || params[:password].blank?
    render_json(false, "Missing login credentials!")
  end

  def invalid_login_attempt
    warden.custom_failure!
    render_json(false, "Invalid login credentials!")
  end

end