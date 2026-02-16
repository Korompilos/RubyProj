class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
  @room = Room.find(params[:room_id])
  @message = @room.messages.build(msg_params)
  @message.user = current_user

  respond_to do |format|
    if @message.save
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message_form", partial: "messages/form", locals: { room: @room, message: Message.new }) }
      format.html { redirect_to @room }
    end
  end
end

  def destroy
  @room = Room.find(params[:room_id])
  @message = @room.messages.find(params[:id])
  
  if @message.user == current_user
    @message.destroy
    
    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to @room }
    end
  end
end

  private 

  def msg_params
    params.require(:message).permit(:content)
  end
end