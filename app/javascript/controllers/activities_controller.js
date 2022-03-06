import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["name", "input"]

  connect() {
  }

  selectActivity() {
    this.element.dispatchEvent(new CustomEvent("activityEvent", {
      detail: {
      activity: this.nameTarget.innerText.toLowerCase()
      },
      bubbles: true		// This needs to be explicitly set to enable event bubbling
    }));
  }
}