class PairingRequest < ApplicationRecord
  belongs_to :pairing_session
  belongs_to :user
end
