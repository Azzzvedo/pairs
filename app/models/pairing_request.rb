class PairingRequest < ApplicationRecord
  belongs_to :pairing_session
  belongs_to :user

  def index
    @pairing_requests = Pairing_request.all
    @pairing_session = Pairing_session.find(pairing_session[:id])
  end
end
