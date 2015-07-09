class ApplicationController < ActionController::Base

  include ApplicationHelper

  before_filter :check_authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  #session :session_key => '_rails_space_session_id'

  # Protect a page from unauthorized access
  def protect
      unless logged_in?
          session[:protected_page] = request.request_uri
          flash[:notice] = "Plaese log in first"
          redirect_to :controller => "user", :action => "login"
          return false
      end
  end


  def check_authorization
  	if cookies[:autorization_token] and not session[:user_id]
  		user = User.find_by_authorization_token(cookies[:autorization_token])
  		user.log_in!(session) if user
  	end
  end

  def param_posted?(sym)
    request.post? and params[sym]
  end

end
