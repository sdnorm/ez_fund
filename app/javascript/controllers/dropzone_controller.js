import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "form"]

  connect() {
    this.dragEventCounter = 0
    this.bindEvents()
  }

  bindEvents() {
    this.element.addEventListener("dragenter", (e) => this.dragenter(e))
    this.element.addEventListener("dragleave", (e) => this.dragleave(e))
    this.element.addEventListener("dragover", (e) => this.dragover(e))
    this.element.addEventListener("drop", (e) => this.drop(e))
  }

  dragenter(e) {
    e.preventDefault()
    this.dragEventCounter++
    this.element.classList.add("border-indigo-600")
  }

  dragleave(e) {
    e.preventDefault()
    this.dragEventCounter--
    if (this.dragEventCounter === 0) {
      this.element.classList.remove("border-indigo-600")
    }
  }

  dragover(e) {
    e.preventDefault()
  }

  drop(e) {
    e.preventDefault()
    this.element.classList.remove("border-indigo-600")
    this.dragEventCounter = 0
    
    const file = e.dataTransfer.files[0]
    if (file && file.type === "text/csv") {
      this.inputTarget.files = e.dataTransfer.files
      this.previewTarget.textContent = file.name
    } else {
      this.previewTarget.textContent = "Please upload a CSV file"
    }
  }

  browse(e) {
    this.inputTarget.click()
  }

  fileChosen(e) {
    const file = this.inputTarget.files[0]
    if (file) {
      this.previewTarget.textContent = file.name
    }
  }
} 