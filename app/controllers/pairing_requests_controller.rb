class PairingRequestsController < ApplicationController
  def index
    @pairing_requests = PairingRequest.all
    # PairingRequest.joins(:pairing_session).where(pairing_session: { user: current_user })

  end

  def create_chat
    @pairing_request = PairingRequest.find(params[:id])
    Chat.new(sender_id: current_user.id, recipient_id: pairing_request.user_id) if @pairing_request.approved == true
  end

  def create
    @pairing_request = PairingRequest.new(pairing_request_params)
    @pairing_session = PairingSession.find(params[:pairing_session_id])
    @pairing_request.pairing_session = @pairing_session
    @pairing_request.user = current_user
    if @pairing_request.save
      redirect_to pairing_request_path(@pairing_request)
    else
      render 'pairing_session/index'
    end
  end

  def update
    @pairing_request = PairingRequest.find(params[:id])
    approve(@pairing_request)
    @pairing_session = @pairing_request.pairing_session
    # inactivate pairing session?
    @chat = Chat.new
    @chat.sender = @pairing_request.user
    @chat.recipient = @pairing_session.user
    @chat.save
    redirect_to chat_path(@chat)
  end

  def show
    @pairing_request = PairingRequest.find(params[:id])
  end

  def destroy
  end

  private

  def approve(pairing_request)
    pairing_request.approved = true
  end

  def pairing_request_params
    params.require(:pairing_request).permit(:introduction)
  end
end
