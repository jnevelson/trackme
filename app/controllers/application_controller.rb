class ApplicationController < ActionController::Base

  protect_from_forgery

  protected

  def render_json(success, message)
    render :json => { :success => success, :message => message }
  end

end
