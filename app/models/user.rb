class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_destroy :delete_chats
  has_many :pairing_sessions, dependent: :destroy
  has_many :pairing_requests, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chats
  has_one_attached :photo, dependent: :destroy

  def unseen_messages
    @unseen_messages = Chat.where(sender_id: self.id).or(Chat.where(recipient_id: self.id)).map do |chat|
      chat.messages.where("user_id != ?", self.id).and(chat.messages.where(seen: false))
    end
    @unseen_messages.flatten!
  end

  private

  def delete_chats
    Chat.where(sender: self).or(Chat.where(recipient: self)).destroy_all
  end
end
