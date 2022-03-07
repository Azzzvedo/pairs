class ChatsController < ApplicationController

  def index
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
    @chats.map { |chat| chat.partner = partner(chat) }
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @partner = partner(@chat)
  end

  private

  def partner(chat)
    current_user.id == chat.sender_id ? chat.recipient : chat.sender
  end
end
