import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["form"]

  connect() {
  }

  sendRequest(event) {
    event.preventDefault()
    this.dispatch( "pairRequest", {
      detail: {
      pairingSessionId: this.element.dataset.id,
      pairingRequestorId: this.element.dataset.userId,
      }})

		// This needs to be explicitly set to enable event bubbling
  }
}
