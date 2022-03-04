import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    // this.inputTargets.forEach(element => console.log(element))
    // console.log(this.inputTargets.indexOf(this.inputTarget))
  }

  displayInput(event) {
    event.preventDefault()
    this.inputTarget.classList.add("d-none")
    this.inputTarget.nextSiblingElement.classList.remove("d-none")
  }
}
