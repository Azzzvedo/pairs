import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["request"]

  connect() {
  }

  handleModalEvent(event) {
    console.log("testing")
    const pairingSessionId = event.detail.pairingSessionId
    console.log(pairingSessionId)
    const pairingRequestorId = event.detail.pairingRequestorId
    console.log(pairingRequestorId)
    this.requestTarget.querySelector("input[name='pairing_request[pairing_session_id]']").setAttribute('value', pairingSessionId)
    this.requestTarget.querySelector("input[name='pairing_request[user_id]']").setAttribute('value', pairingRequestorId)
    // this.requestFormTarget.querySelector('input[name="pairing_request[pairing_session_id]"]').setAttribute('value', pairingSessionId)
    // this.requestFormTarget.querySelector('input[name="pairing_request[pairing_requestor_id]"]').setAttribute('value', pairingRequestorId)
    // this.messageTarget.textContent = `Message from child: ${message}`;
  }

}
