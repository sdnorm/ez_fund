import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"]
  static values = {
    required: Boolean,
    pattern: String,
    minLength: Number,
    maxLength: Number
  }

  connect() {
    this.validateOnInput()
    this.validateOnSubmit()
  }

  validateOnInput() {
    this.inputTargets.forEach(input => {
      input.addEventListener("input", () => this.validateField(input))
    })
  }

  validateOnSubmit() {
    this.formTarget.addEventListener("submit", (e) => {
      let isValid = true
      this.inputTargets.forEach(input => {
        if (!this.validateField(input)) {
          isValid = false
        }
      })
      
      if (!isValid) {
        e.preventDefault()
      }
    })
  }

  validateField(input) {
    let isValid = true

    if (this.requiredValue && !input.value) {
      isValid = false
      this.showError(input, "This field is required")
    }

    if (this.patternValue && !new RegExp(this.patternValue).test(input.value)) {
      isValid = false
      this.showError(input, "Invalid format")
    }

    if (this.minLengthValue && input.value.length < this.minLengthValue) {
      isValid = false
      this.showError(input, `Minimum length is ${this.minLengthValue}`)
    }

    if (this.maxLengthValue && input.value.length > this.maxLengthValue) {
      isValid = false
      this.showError(input, `Maximum length is ${this.maxLengthValue}`)
    }

    if (isValid) {
      this.clearError(input)
    }

    return isValid
  }

  showError(input, message) {
    let errorDiv = input.nextElementSibling
    if (!errorDiv || !errorDiv.classList.contains("error-message")) {
      errorDiv = document.createElement("div")
      errorDiv.classList.add("error-message", "text-red-500", "text-sm", "mt-1")
      input.parentNode.insertBefore(errorDiv, input.nextSibling)
    }
    errorDiv.textContent = message
    input.classList.add("border-red-500")
  }

  clearError(input) {
    const errorDiv = input.nextElementSibling
    if (errorDiv && errorDiv.classList.contains("error-message")) {
      errorDiv.remove()
    }
    input.classList.remove("border-red-500")
  }
} 