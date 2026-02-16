class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_ids = Array(params[:user_ids]).reject(&:blank?)
    user_ids << current_user.id.to_s 
    
    timestamp = Time.now.to_i
    room_name = user_ids.count > 2 ? "Group-#{timestamp}" : "Private-#{timestamp}"

    @room = Room.new(name: room_name)
    @room.users = User.where(id: user_ids)

    if @room.save
      redirect_to room_path(@room), status: :see_other 
    else
      redirect_back fallback_location: root_path, alert: "Αποτυχία: #{@room.errors.full_messages.join(', ')}"
    end
  end

  def show
    @single_room = Room.find(params[:id])
    @user = @single_room.users.where.not(id: current_user.id).first
    @messages = @single_room.messages.order(created_at: :asc)
    @message = Message.new
    render "users/show"
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to my_friends_path, status: :see_other, notice: "Η συνομιλία διαγράφηκε."
  end
end