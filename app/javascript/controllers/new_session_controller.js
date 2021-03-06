import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["activity", "address", "time", "description", "form", "container", "button", "mapContainer", "addressInput"]

  connect() {
    console.log("new_session controller connect success")
  }

  handleEvent(event) {
    event.preventDefault()
    console.log("activityEvent dispatch success")
    const activity = event.detail.activity
    this.activityTarget.querySelector('input').setAttribute('value', activity)
    this.activityTarget.classList.add("d-none")
    this.timeTarget.classList.remove("d-none")
    const str = (new Date()).toISOString().slice(0, 16).replace(/-/g, "-");
    this.timeTarget.querySelector('input').setAttribute('value', str)
  }

  displayAddress() {
    this.timeTarget.classList.add("d-none")
    this.addressTarget.classList.remove("d-none")
    const activity = this.activityTarget.querySelector('input').value
    const time = this.timeTarget.querySelector('input').value

    fetch("/pairing_sessions?" + new URLSearchParams({"activity": activity, "time": time }), {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })
      .then(response => response.json())
      .then((data) => {
        this.mapContainerTarget.innerHTML = data.map
      })
  }

  setTimeNow() {
    const date = (new Date()).toISOString().slice(0, 16).replace(/-/g, "-");
    this.timeTarget.querySelector('input').setAttribute('value', date)
  }

  setTimeTonight() {
    const date = (new Date())
    date.setHours(18)
    date.setMinutes(0)
    this.timeTarget.querySelector('input').setAttribute('value', date.toISOString().slice(0, 16).replace(/-/g, "-"))
  }

  setTimeTommorow() {
    const date = (new Date())
    date.setDate(date.getDate() + 1)
    date.setHours(12)
    date.setMinutes(0)
    this.timeTarget.querySelector('input').setAttribute('value', date.toISOString().slice(0, 16).replace(/-/g, "-"))
  }

  displayPairingSessions(event) {
    event.preventDefault()
    this.addressTarget.classList.add("d-none")
    console.log("connected")
    let address = ''
    console.log(this.addressTarget.querySelector('input').value.length)
    if (this.addressTarget.querySelector('input').value.length !== 0) {
      address = this.addressTarget.querySelector('input').value
    } else {
      address = 'london'
    }
    const activity = this.activityTarget.querySelector('input').value
    const time = this.timeTarget.querySelector('input').value

    fetch("/pairing_sessions?" + new URLSearchParams({ "address": address, "activity": activity, "time": time }), {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
    })
      .then(response => response.json())
      .then((data) => {
      this.containerTarget.innerHTML = data.results
      })
  }
}
