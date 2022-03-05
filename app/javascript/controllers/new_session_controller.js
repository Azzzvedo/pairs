import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["activity", "address", "time", "description", "form", "container"]

  connect() {
    // this.inputTargets.forEach(element => console.log(element))
    // console.log(this.inputTargets.indexOf(this.inputTarget))
  }

  handleEvent(event) {
    event.preventDefault()
    const activity = event.detail.activity
    this.activityTarget.querySelector('input').setAttribute('value', activity)
    // let message = ev.detail.message;
    // this.activityTarget.setAttribute('value', activity);
    this.activityTarget.classList.add("d-none")
    this.addressTarget.classList.remove("d-none")
    // this.messageTarget.textContent = `Message from child: ${message}`;
    }

  displayAddress() {
    // event.preventDefault()
    this.activityTarget.classList.add("d-none")
    this.addressTarget.classList.remove("d-none")
  }

  displayTime(event) {
    event.preventDefault()
    this.addressTarget.classList.add("d-none")
    this.timeTarget.classList.remove("d-none")
  }

  displayDescription(event) {
    event.preventDefault()
    this.timeTarget.classList.add("d-none")
    this.descriptionTarget.classList.remove("d-none")
  }

  displayPairingSessions(event) {
    event.preventDefault()
    this.timeTarget.classList.add("d-none")
    const activity = this.activityTarget.querySelector('input').value
    const address = this.addressTarget.querySelector('input').value
    const time = this.timeTarget.querySelector('input').value
    // const time = Array.from(times).find(radio => radio.checked).value;

    fetch(this.formTarget.action + "?" + new URLSearchParams({ "address": address, "activity": activity, "time": time }), {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      // body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
      this.containerTarget.innerHTML = data.results
      })
  }
}
