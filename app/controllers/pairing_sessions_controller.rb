class PairingSessionsController < ApplicationController

  def index
    @pairing_sessions = PairingSession.all
    @markers = @pairing_sessions.geocoded.map do |pairing_session|
      {
        lat: pairing_session.latitude,
        lng: pairing_session.longitude
      }
    end
  end

  def new
    @pairing_session = PairingSession.new

  end

  def create
    @pairing_session = PairingSession.new(pairing_session_params)
    @pairing_session.user = current_user
    if @pairing_session.save
      redirect_to pairing_sessions_path
    else
      render 'new'
    end
  end

  private

  def pairing_session_params
    params.require(:pairing_session). permit(:activity, :address, :time, :description)
  end
end
