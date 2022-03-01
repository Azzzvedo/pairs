class PairingSessionsController < ApplicationController


  # def index
  #   @pairing_sessions = PairingSession.all
  # end

  def new
    @pairing_session = PairingSession.new
  end

  # def update
  # end
end
