class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.create(user: current_user, content: msg_params[:content])
  end

  def destroy
    @room = Room.find(params[:room_id])
    @message = @room.messages.find(params[:id])
    
    if @message.user == current_user
      @message.destroy
    end

    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to @room }
    end
  end

  private 

  def msg_params
    params.require(:message).permit(:content)
  end
end