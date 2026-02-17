class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    selected_user_ids = Array(params[:user_ids]).reject(&:blank?)
    
    if selected_user_ids.count < 2
      return redirect_back fallback_location: root_path, 
                           alert: "Επιλέξτε τουλάχιστον 2 φίλους για να ξεκινήσετε ομαδική συνομιλία."
    end

    all_participant_ids = selected_user_ids << current_user.id.to_s
    timestamp = Time.now.to_i
    
    @room = Room.new(name: "Group-#{timestamp}")
    @room.users = User.where(id: all_participant_ids)

    if @room.save
      redirect_to room_path(@room), status: :see_other
    else
      redirect_back fallback_location: root_path, alert: "Σφάλμα κατά τη δημιουργία."
    end
  end

  def show
    @single_room = Room.find(params[:id])
    @user = @single_room.users.where.not(id: current_user.id).first
    @messages = @single_room.messages.order(created_at: :asc)
    @message = Message.new
    render "users/show"
  end
end