class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pairing_sessions
  has_many :pairing_requests
  has_many :messages
  has_many :chats
  has_one_attached :photo
end
