import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["name", "input"]

  connect() {
    console.log("activities_controller connect success")
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
