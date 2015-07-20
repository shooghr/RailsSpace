class AvatarController < ApplicationController
  before_filter :protect

  def index
  	redirect_to hub_url
  end

  def upload
  	@title = "Upload Your Avatar"
  	@user = User.find(session[:user_id])
  end

  def delete
  end
end
