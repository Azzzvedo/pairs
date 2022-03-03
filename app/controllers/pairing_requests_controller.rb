class PairingRequestsController < ApplicationController
  def index
    @pairing_sessions = current_user.pairing_sessions
  end

  def create
    # @pairing_request = PairingRequest.new(user: current_user)
    # @pairing_request.pairing_session =
  end

  def destroy
  end
end
