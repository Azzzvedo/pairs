class PairingSessionsController < ApplicationController
  def index
    if params[:activity] && params[:time] && params[:address]

      t_now = DateTime.now
      t_selected = params[:time].to_datetime

      if t_selected - 12.hours > t_now
        start_time =  t_selected - 12.hours
      else
        start_time =  t_now - 1.hours
      end
      time_range = (start_time..(params[:time].to_datetime + 12.hours))

      request_objects = PairingRequest.where("approved = true").select(:pairing_session_id).distinct.to_a
      approved_pairing_session_ids = request_objects.map {|r| r.pairing_session_id}
      @pairing_sessions = PairingSession.where.not(id: approved_pairing_session_ids).where.not(user: current_user).where(activity: params[:activity]).where(datetime: time_range)
      @pairing_sessions = @pairing_sessions.sort_by do |pairing_session|
        Geocoder::Calculations.distance_between([pairing_session.latitude, pairing_session.longitude], Geocoder.search(params[:address]).first.coordinates)
      end
      @pairing_session = PairingSession.new(activity: params[:activity], datetime: params[:time], address: params[:address])
    else
      if params[:activity]
        @pairing_sessions_for_map = PairingSession.where.not(user: current_user).where(activity: params[:activity])
          @markers = @pairing_sessions_for_map.geocoded.map do |pairing_session|
          {
            lat: pairing_session.latitude,
            lng: pairing_session.longitude,
            info_window: render_to_string(partial: "info_window", locals: { pairing_session: pairing_session }),
            image_url: helpers.asset_url("table-tennis-paddle-ball-solid.svg")
              }
          end
      end
      @pairing_session = PairingSession.new
    end
    @pairing_request = PairingRequest.new
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
      redirect_to pairing_requests_path
    else
      render :pairing_sessions
    end
  end

  private

  def pairing_session_params
    params.require(:pairing_session).permit(:activity, :address, :description, :datetime)
  end
end
