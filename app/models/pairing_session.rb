class PairingSession < ApplicationRecord
  belongs_to :user
  has_many :pairing_requests
end
