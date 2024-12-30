import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggleable", "menuIcon", "closeIcon"]

  toggle() {
    this.toggleableTarget.classList.toggle("hidden")
    this.menuIconTarget.classList.toggle("hidden")
    this.closeIconTarget.classList.toggle("hidden")
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.toggleableTarget.classList.add("hidden")
      this.menuIconTarget.classList.remove("hidden")
      this.closeIconTarget.classList.add("hidden")
    }
  }

  connect() {
    // Hide menu when clicking outside
    document.addEventListener("click", this.hide.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.hide.bind(this))
  }
} 