class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @lessons = ["Algebra I", "Algebra II", "C#", "Operating Systems", "Databases", "Python", "Android Studio"]
    
    if params[:category].present?
      @posts = Post.where(category: params[:category]).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post made!"
    else
      redirect_to posts_path, alert: "Something went wrong."
    end
  end

  def edit
    @lessons = ["Algebra I", "Algebra II", "C#", "Operating Systems", "Databases", "Python", "Android Studio"]
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post edited succesfully!"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted!"
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id]) 
  end

  def post_params
    params.require(:post).permit(:content, :category)
  end
end