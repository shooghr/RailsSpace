require 'digest/sha1'

class UserController < ApplicationController

  include ApplicationHelper

  helper :profile, :avatar

  #layout "site"

  before_action :permition, only:[:register, :login, :edit]
  #before-action :permition, except: :index
  before_filter :protect, only: [:index, :edit, :edit_password]
  #before_action :protect, execpt:[:register, :index]

  def index
    #unless session[:user_id]
     # flash[:notice] = "Please log in first"
      #redirect_to :action => "login"
      # Uh oh, no return
    #end
    @title = "RailsSpace User Hub"
    @user = User.find(session[:user_id])

    @user.spec ||= Spec.new
    @spec = @user.spec

    @user.faq ||= Faq.new
    @faq = @user.faq
    
  end

  def register
  	@title = "Register"


  	if param_posted?(:user)
  		logger.info params[:user].inspect

  		@user = User.new(params[:user])
  		if @user.save
        @user.login!(session)
  			flash[:notice] = "User  #{@user.screen_name} created!"
        redirect_to_forwarding_url
  		else
        @user.clear_password!
      end
  	end
  end

  def login

    @title = "Log in to RailsSpace"

    if request.get?
      @user = User.new(:remember_me => remember_me_string)
    elsif param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name, @user.password)
      if user
        user.login!(session)
        @user.remember_me? ? user.remember!(cookies) : user.forget!(cookies)
        flash[:notice] = "User #{user.screen_name} logged in!"
        redirect_to_forwarding_url
      else
        # Don't show the password in the view
        @user.clear_password!
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end

  def logout
    User::logout!(session, cookies)
    flash[:notice] = "logged out"
    redirect_to :action => "index", :controller => "site"
  end

  def edit
    @title = "Edit basic info"
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end
      end
    end
    @user.clear_password!
  end

  private

  def permition
    params.permit!
  end

  def protect
    #unless session[:user_id]
    unless logged_in?
      session[:protected_page] = request.url
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return false
    end
  end

  def redirect_to_forwarding_url
    if(redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end

  def remember_me_string
    cookies[:remember_me] || "0"
  end

  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "User #{attribute} update."
      redirect_to :action => "index"
    end
  end

end
