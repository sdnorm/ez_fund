import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "firstName", "lastName", "email", "password", "passwordConfirmation"]

  connect() {
    this.formTarget.setAttribute("novalidate", true)
  }

  validate(event) {
    if (!this.formTarget.checkValidity()) {
      event.preventDefault()
      this.showErrors()
    }
  }

  showErrors() {
    // Show validation messages for each field
    this.validateRequired(this.firstNameTarget, "First name is required")
    this.validateRequired(this.lastNameTarget, "Last name is required")
    this.validateEmail()
    this.validatePassword()
    this.validatePasswordConfirmation()
  }

  validateRequired(field, message) {
    if (!field.value) {
      field.classList.add("border-red-500")
      this.showErrorMessage(field, message)
    } else {
      field.classList.remove("border-red-500")
      this.removeErrorMessage(field)
    }
  }

  validateEmail() {
    const field = this.emailTarget
    if (!field.value) {
      this.showErrorMessage(field, "Email is required")
    } else if (!field.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      this.showErrorMessage(field, "Please enter a valid email address")
    } else {
      this.removeErrorMessage(field)
    }
  }

  validatePassword() {
    const field = this.passwordTarget
    if (field.value.length < 6) {
      this.showErrorMessage(field, "Password must be at least 6 characters")
    } else {
      this.removeErrorMessage(field)
    }
  }

  validatePasswordConfirmation() {
    const field = this.passwordConfirmationTarget
    if (field.value !== this.passwordTarget.value) {
      this.showErrorMessage(field, "Passwords do not match")
    } else {
      this.removeErrorMessage(field)
    }
  }

  showErrorMessage(field, message) {
    field.classList.add("border-red-500")
    let error = field.nextElementSibling
    if (!error || !error.classList.contains("error-message")) {
      error = document.createElement("p")
      error.classList.add("error-message", "text-red-500", "text-sm", "mt-1")
      field.parentNode.insertBefore(error, field.nextSibling)
    }
    error.textContent = message
  }

  removeErrorMessage(field) {
    field.classList.remove("border-red-500")
    const error = field.nextElementSibling
    if (error?.classList.contains("error-message")) {
      error.remove()
    }
  }
} 