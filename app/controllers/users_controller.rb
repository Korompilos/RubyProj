class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def my_friends
    @friends = current_user.all_friends
  end

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    
    users = [@current_user, @user].sort_by(&:id)
    room_name = "chat_#{users[0].id}_#{users[1].id}"

    @single_room = Room.where(name: room_name).first || Room.create_private_room(users, room_name)
    
    @messages = @single_room.messages.order(created_at: :asc)
    @message = Message.new
    
  end
end