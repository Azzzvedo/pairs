import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatId: Number }
  static targets = ["messages", "form"]

  connect() {
    console.log(this.formTarget)
    this.channel = consumer.subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      { received: (data) => this.#insertMessageScrollDownAndResetForm(data) }
      )
    }

    disconnect() {
      this.channel.unsubscribe()
    }

  #insertMessageScrollDownAndResetForm(data) {
    console.log(data)
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.formTarget.reset()
    this.formTarget.scrollIntoView()
  }
}
