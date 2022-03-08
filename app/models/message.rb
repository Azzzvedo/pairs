class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  validates :content, length: { minimum: 1 }
end
