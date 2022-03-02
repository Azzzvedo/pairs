import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["activity", "address", "time", "description"]

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


}
