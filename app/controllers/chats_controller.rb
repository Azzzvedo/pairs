class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    if current_user == @chat.sender
      @owner = @chat.sender
      @other = @chat.recipient
    else
      @owner = @chat.recipient
      @other = @chat.sender
    end
  end
end
