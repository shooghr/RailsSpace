class CommentsController < ApplicationController
	helper :profile, :avatar
	include ProfileHelper
	before_filter :protect, :load_post

	def new
		@comment = Comment.new

		respond_to do |format|
			format.js
		end
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user = User.find(session[:user_id])
		@comment.post = @post

		respond_to do |format|
			if @comment.duplicate? or @post.comments << @comment
				format.js
			elsif @comment.save
				format.js
			else
				format.js {render :nothing => true }
			end
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		user = User.find(session[:user_id])

		respond_to do |format|
			if @comment.authorized?(user)
				@comment.destroy
				format.js 
			else
				format.js {render :nothing => true }
			end	
		end
	end

	private

	def load_post
		@post = Post.find(params[:post_id])
	end

	def comment_params
		params.require(:comment).permit(:body, :user_id, :post_id)
	end
end
