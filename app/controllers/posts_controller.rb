class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @lessons = ["Algebra I", "Algebra II", "C#", "Operating Systems", "Databases", "Python", "Android Studio"]
    
    @posts = Post.includes(:user).order(created_at: :desc)

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end

    if params[:query].present?
      @posts = @posts.where("content ILIKE ?", "%#{params[:query]}%")
    end

    @posts = @posts.page(params[:page]).per(5)

    @post = Post.new
    @recent_activity = Post.order(created_at: :desc).limit(4)

    my_room_ids = Participant.where(user_id: current_user.id).pluck(:room_id)

    all_my_rooms = Room.where(id: my_room_ids)

    @my_private_chats = all_my_rooms.where(is_private: true)
    @my_group_chats   = all_my_rooms.where(is_private: false)

    @friends = User.where.not(id: current_user.id)
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