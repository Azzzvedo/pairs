import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["request"]

  connect() {
    console.log("new_request_controller connect success")
  }

  handleModalEvent(event) {
    console.log("dispatch received success")
    const pairingSessionId = event.detail.pairingSessionId
    const pairingRequestorId = event.detail.pairingRequestorId
    this.requestTarget.querySelector("input[name='pairing_request[pairing_session_id]']").setAttribute('value', pairingSessionId)
    this.requestTarget.querySelector("input[name='pairing_request[user_id]']").setAttribute('value', pairingRequestorId)
    // this.requestFormTarget.querySelector('input[name="pairing_request[pairing_session_id]"]').setAttribute('value', pairingSessionId)
    // this.requestFormTarget.querySelector('input[name="pairing_request[pairing_requestor_id]"]').setAttribute('value', pairingRequestorId)
    // this.messageTarget.textContent = `Message from child: ${message}`;
  }

}
