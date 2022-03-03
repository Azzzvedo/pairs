class ChatsController < ApplicationController

  def index
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
    if @chats.empty?
      redirect_to new_pairing_session_path
    else
      @chats.map { |chat| chat.partner = partner(chat) }
    end
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

  def index
    @chats = Chat.all
  end
end
