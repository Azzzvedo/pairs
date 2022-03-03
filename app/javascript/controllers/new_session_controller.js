import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["activity", "address", "time", "description", "form", "container"]

  connect() {
    // this.inputTargets.forEach(element => console.log(element))
    // console.log(this.inputTargets.indexOf(this.inputTarget))
  }

  displayAddress() {
    event.preventDefault()
    this.activityTarget.classList.add("d-none")
    this.addressTarget.classList.remove("d-none")
  }
  displayTime() {
    event.preventDefault()
    this.addressTarget.classList.add("d-none")
    this.timeTarget.classList.remove("d-none")
  }
  displayDescription() {
    event.preventDefault()
    this.timeTarget.classList.add("d-none")
    this.descriptionTarget.classList.remove("d-none")
  }
  displayPairingSessions() {
    event.preventDefault()
    this.timeTarget.classList.add("d-none")
    const activities = this.activityTarget.querySelector('fieldset').elements
    const activity = Array.from(activities).find(radio => radio.checked).value;
    const address = this.addressTarget.querySelector('input').value
    const times = this.timeTarget.querySelector('fieldset').elements
    const time = Array.from(times).find(radio => radio.checked).value;

    fetch(this.formTarget.action + "?" + new URLSearchParams({ "address": address, "activity": activity, "time": time }), {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      // body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
      console.log("I am here!")
      console.log(data)
      this.containerTarget.innerHTML = data.results
      })
  }

}
