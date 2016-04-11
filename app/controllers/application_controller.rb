class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  protected
  def authenticate_user!
    if current_user
      #TODO check if profile is created, redirect to profile create page if not
    else
      redirect_to "/auth/google_oauth2"
    end
  end
  
end
