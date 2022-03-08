class ChatsController < ApplicationController

  def index
    @chats = Chat.where(sender: current_user).or(Chat.where(recipient: current_user))
    @chats.map { |chat| chat.partner = partner(chat) }
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @partner = partner(@chat)
    @chat.messages.each do |message|
      if message.user_id != current_user.id
        message.seen = true
        message.save
      end
    end
  end

  def check_chat_user(user)
    user.id == sender_id || user.id == recipient_id
  end

  private

  def partner(chat)
    current_user.id == chat.sender_id ? chat.recipient : chat.sender
  end
end
