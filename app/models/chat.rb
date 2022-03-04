class Chat < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :recipient, class_name: :User
  has_many :messages, dependent: :destroy
  attr_accessor :partner
end
