class PairingSessionsController < ApplicationController


  # def index
  #   @pairing_sessions = PairingSession.all
  # end

  def new
    @pairing_session = PairingSession.new
    @pairing_sessions = PairingSession.all
    @markers = @pairing_sessions.geocoded.map do |pairing_session|
      {
        lat: pairing_session.latitude,
        lng: pairing_session.longitude
      }
    end
  end

  # def update
  # end
end
