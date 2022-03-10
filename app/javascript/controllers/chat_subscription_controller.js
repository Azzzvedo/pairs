import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatId: Number }
  static targets = ["messages", "form", "message"]

  connect() {
    console.log(this.formTarget)
    this.messagesTarget.scrollTo(0,this.messagesTarget.scrollHeight);
    this.channel = consumer.subscriptions.create(
      { channel: "ChatChannel", id: this.chatIdValue },
      { received: (data) => this.#insertMessageScrollDownAndResetForm(data) }
      )
      this.styleMessages()
    }

    disconnect() {
      this.channel.unsubscribe()
    }

    styleMessages() {
      console.log(this.messageTargets);
      this.messageTargets.forEach((msg) => {
        console.log(msg.dataset);
        const senderId = msg.dataset.senderId
        console.log(this.element.dataset)
        const currentUserId = this.element.dataset.currentUserId
        console.log(senderId)
        console.log(currentUserId)
        if (currentUserId == senderId) {
          console.log("msg from same user")
          msg.classList.add("current")
        } else {
          msg.classList.add("other")
          console.log("msg from other user")
        }
      })
    }

  #insertMessageScrollDownAndResetForm(data) {
    console.log(data)
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.formTarget.scrollIntoView()
    this.styleMessages()
  }
}
