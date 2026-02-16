class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
  @room = Room.find(params[:room_id])
  @message = @room.messages.build(msg_params)
  @message.user = current_user

  if @message.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("messages", partial: "messages/message", locals: { message: @message, session_user_id: current_user.id }),
          turbo_stream.replace("new_message_form", partial: "messages/form", locals: { room: @room, message: Message.new })
        ]
      end
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