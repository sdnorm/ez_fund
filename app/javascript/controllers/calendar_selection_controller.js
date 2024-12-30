import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["day"]
  static values = {
    timeoutDuration: { type: Number, default: 240000 }, // 4 minutes in milliseconds
    calendarId: Number
  }

  connect() {
    this.timeouts = new Map()
    this.subscribeToUpdates()
  }

  disconnect() {
    this.clearAllTimeouts()
  }

  // Handle day selection
  selectDay(event) {
    const dayElement = event.currentTarget
    const dayId = dayElement.dataset.dayId

    // Prevent selection if already purchased or selected by someone else
    if (dayElement.dataset.status === "purchased") return

    this.startSelectionTimeout(dayId)
    this.updateDayStatus(dayId, "selected")
  }

  // Start timeout for selected day
  startSelectionTimeout(dayId) {
    // Clear existing timeout if any
    this.clearTimeout(dayId)

    const timeout = setTimeout(() => {
      this.clearSelection(dayId)
    }, this.timeoutDurationValue)

    this.timeouts.set(dayId, timeout)
  }

  // Clear specific timeout
  clearTimeout(dayId) {
    if (this.timeouts.has(dayId)) {
      clearTimeout(this.timeouts.get(dayId))
      this.timeouts.delete(dayId)
    }
  }

  // Clear all timeouts
  clearAllTimeouts() {
    this.timeouts.forEach((timeout) => clearTimeout(timeout))
    this.timeouts.clear()
  }

  // Clear selection for a specific day
  clearSelection(dayId) {
    this.updateDayStatus(dayId, "available")
    this.clearTimeout(dayId)
  }

  // Update day status via Turbo Stream
  async updateDayStatus(dayId, status) {
    try {
      await fetch(`/calendar_days/${dayId}/update_status`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ status })
      })
    } catch (error) {
      console.error("Error updating day status:", error)
    }
  }

  // Subscribe to calendar updates
  subscribeToUpdates() {
    // Handled by Turbo Streams automatically via model broadcasting
  }
} 