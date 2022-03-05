class PairingSessionsController < ApplicationController
  def index
    if params[:activity] && params[:time] && params[:address]
      # time_range = (Time.now..Time.now + (params[:time].to_i * 60))
      @pairing_sessions = PairingSession.where.not(user: current_user).where(activity: params[:activity])#.where(datetime: time_range)
      # @pairing_sessions = @pairing_sessions.select do |pairing_session|
      # Geocoder::Calculations.distance_between([pairing_session.latitude, pairing_session.longitude], Geocoder.search(params[:address]).first.address) < 10
      # end

    else
      @pairing_sessions = PairingSession.all
      @markers = @pairing_sessions.geocoded.map do |pairing_session|
        {
          lat: pairing_session.latitude,
          lng: pairing_session.longitude,
          # info_window: render_to_string(partial: "info_window", locals: { pairing_session: pairing_session }),
          image_url: helpers.asset_url("fire-flame.svg")
        }
      end
    end
    @pairing_request = PairingRequest.new
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
    params.require(:pairing_session).permit(:activity, :address, :time, :description, :datetime)
  end
end
