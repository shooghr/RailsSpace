class PostsController < ApplicationController
  helper :profile
  before_filter :protect, :protect_blog
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @title = "Blog Management"

    respond_to do |format|     
        format.html { render :index }
        format.xml  { render :xml => @posts.to_xml}
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @title = @post.title

    respond_to do |format|
        format.html { render :show }
        format.xml  { render :xml => @post.to_xml}
        format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @title = "Add a new post"
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.xml  { head :created, :location => post_url(@post) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.xml  { render :xml => @post.errors.to_xml }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.xml  { head :ok }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.xml  { render :xml => @post.errors.to_xml}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.xml  {head :ok }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:blog_id, :title, :body)
    end

    # Ensure that user is blob owner, and create @blog.
    def protect_blog
      @blog = Blog.find(params[:blog_id])
      user  = User.find(session[:user_id])
      unless @blog.user == user
        flash[:notice] = "That isn't your blog!"
        redirect_to hub_url
        return false
      end
    end
end
