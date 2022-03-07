class PairingRequestsController < ApplicationController
  def index
    @user_pairing_sessions = PairingSession.where(user: current_user)
    @pairing_requests = PairingRequest.where(pairing_sessions: @user_pairing_sessions).where(approved: nil)
  end

  def create_chat
    @pairing_request = PairingRequest.find(params[:id])
    Chat.new(sender_id: current_user.id, recipient_id: pairing_request.user_id) if @pairing_request.approved == true
  end

  def create
    @pairing_request = PairingRequest.new(pairing_request_params)
    if @pairing_request.save
      redirect_to pairing_requests_path
    else
      redirect_to pairing_sessions_path
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
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render 'pairing_sessions'
    end
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
    params.require(:pairing_request).permit(:introduction, :pairing_session_id, :user_id)
  end
end
