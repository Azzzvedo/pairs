import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["form"]

  connect() {

  }

  sendRequest(event) {
    const pairingSessionId = this.element.dataset.id
    const pairingRequestorId = this.element.dataset.userId
    // this.formTarget.classList.remove("d-none")
  }
}
