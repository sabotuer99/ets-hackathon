class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :gravitar_url
  

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def gravitar_url
    # include MD5 gem, should be part of standard ruby install
    require 'digest/md5'
     
    # get the email from URL-parameters or what have you and make lowercase
    email_address = current_user.email.downcase
     
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
     
    # compile URL which can be used in <img src="RIGHT_HERE"...
    image_src = "https://secure.gravatar.com/avatar/#{hash}?d=mm"
  end
  
  protected
  def authenticate_user!
    
    if current_user
      profile_id = Profile.select {|p| p.email == current_user.email}.first.id rescue nil
      if profile_id 
        current_user.profile_id = profile_id
        current_user.profile = Profile.find(profile_id);
        
        #if a destination is in the session, clear the value and redirect to it
        if cookies[:destination]
          dest = cookies[:destination]
          cookies.delete :destination
          redirect_to dest
        end
      else
        redirect_to new_profile_path + "?email=" + current_user.email + "&user_name=" + current_user.name
      end
    else
      cookies[:destination] = request.fullpath
      redirect_to '/login'
    end
  end
  
end
