import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timer = setInterval(() => {
      this.element.src = "/posts";

      this.element.reload();
    }, 5000)
  }

  disconnect() {
    clearInterval(this.timer)
  }
}