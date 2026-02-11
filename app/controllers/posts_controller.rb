class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
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
      redirect_to posts_path, notice: "Το post αναρτήθηκε!"
    else
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :category)
  end
end