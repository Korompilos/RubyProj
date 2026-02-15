class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.create(user: current_user, content: msg_params[:content])
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end