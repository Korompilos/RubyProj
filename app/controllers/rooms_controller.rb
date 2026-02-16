class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @single_room = Room.find(params[:id])
    @user = @single_room.users.where.not(id: current_user.id).first 
    @messages = @single_room.messages.order(created_at: :asc)
    @message = Message.new
    
    render "users/show"
  end
end