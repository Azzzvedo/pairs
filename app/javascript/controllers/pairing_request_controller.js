import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"]

  connect() {
  }

  reject(event) {
    event.preventDefault()
    console.log("reject")
    this.formTarget.querySelector('input#pairing_request_approved').checked = false
    this.formTarget.submit()
    // this.timeTarget.classList.add("d-none")
    // const activity = this.activityTarget.querySelector('input').value
    // const address = this.addressTarget.querySelector('input').value
    // const time = this.timeTarget.querySelector('input').value

    // fetch(this.formTarget.action + "?" + new URLSearchParams({ "address": address, "activity": activity, "time": time }), {
    //   method: "GET",
    //   headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    // })
    //   .then(response => response.json())
    //   .then((data) => {
    //   this.containerTarget.innerHTML = data.results
    //   })
  }

  pair(event) {
    event.preventDefault()
    console.log("accept")
    this.formTarget.querySelector('input#pairing_request_approved').checked = true
    this.formTarget.submit()

  }
}
