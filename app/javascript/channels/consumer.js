import { createConsumer } from "@rails/actioncable"

export default createConsumer()

import consumer from "./consumer";
const insertIntoDOM = (messageHTML, currentUserId, messages) => {
  const message = document.createElement('div')
  message.innerHTML = messageHTML;

  if (message.dataset.senderId === currentUserId) {

    message.firstChild.classList.add('message  current');
  } else {

    message.firstChild.classList.add('message  other');
  }

  messages.insertAdjacentElement('beforeend', message);
}

const Chat = () => {

  const messages = document.getElementsByClassName('messages');

  if (messages) {

    const chatId = messages.dataset.chatId;
    const currentUserId = messages.dataset.currentUserId;


    consumer.subscriptions.create(
      { channel: 'ChatChannel', id: chatId },
      {
        received(messageHTML) {
          console.log(messageHTML)
          insertIntoDOM(messageHTML, currentUserId, messages);
        }
      }
    )
  }
}
