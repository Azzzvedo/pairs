class PairingSessionsController < ApplicationController
  def index
    if params[:activity] && params[:time] && params[:address]
      @pairing_sessions = PairingSession.where.not(user: current_user)
      @pairing_sessions = @pairing_sessions.select do |pairing_session|
        pairing_session.activity == params[:activity]
        Geocoder::Calculations.distance_between([pairing_session.latitude, pairing_session.longitude], Geocoder.search(params[:address]).first.address) < 10
      end
    end
    @pairing_session = PairingSession.new
    respond_to do |format|
      format.html { render "index" }
      format.json # Follow the classic Rails flow and look for a create.json view
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
    params.require(:pairing_session).permit(:activity, :address, :time, :description)
  end
end
