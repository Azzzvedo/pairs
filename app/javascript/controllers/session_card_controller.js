import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
    console.log("session-card controller connect success")
  }

  sendRequest(event) {
    event.preventDefault()
    this.dispatch( "pairRequest", {
      detail: {
      pairingSessionId: this.element.dataset.id,
      pairingRequestorId: this.element.dataset.userId,
      }})
  }
}
