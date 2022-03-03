class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.user = current_user
    if @message.save
      ChatChannel.broadcast_to(
        @chat, render_to_string(partial: 'message', locals: { message: @message })
      )
      head :ok
    else
      render 'chats/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
