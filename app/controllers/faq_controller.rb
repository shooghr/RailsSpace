class FaqController < ApplicationController
  
  before_filter :protect
  before_action :permition, only: :edit

  def index
  	redirect_to hub_url
  end

  def edit
  	@title = "Edit FAQ"
  	@user = User.find(session[:user_id])
  	@user.faq ||= Faq.new
  	@faq = @user.faq
  	if param_posted?(:faq)
  		if @user.faq.update_attributes(params[:faq])
  			flash[:notice] = "FAQ saved."
  			redirect_to hub_url
  		end
  	end
  end

  def permition
  	params.permit!
  end

end
