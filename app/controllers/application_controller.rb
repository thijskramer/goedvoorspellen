class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  
  def current_user
  	@current_user ||= User.valid.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
  	!!current_user
  end

  def require_login
    unless signed_in?
        redirect_to login_url
    end
  end

  helper_method :current_user, :signed_in?, :current_event

  def current_user=(user)
  	@current_user = user
  	session[:user_id] = user.id
  end
end
