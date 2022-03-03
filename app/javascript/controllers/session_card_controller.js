import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["form"]

  connect() {

  }

  sendRequest(event) {
    console.log('clicked')
    console.log(this.element.dataset.id)
    console.log(this.element.dataset.userId)

    const pairingSessionId = this.element.dataset.id
    const pairingRequestorId = this.element.dataset.userId

    this.formTarget.classList.remove("d-none")

    // fetch(this.formTarget.action + "?" + new URLSearchParams({ "pairing_session_id": pairingSessionId, "user_id": pairingRequestorId }), {
    //   method: "POST",
    //   headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    //   body: new FormData(this.formTarget)
    // })
    //   .then(response => response.json())
    //   .then((data) => {
    //   this.containerTarget.innerHTML = data.results
    //   })
  }
}
