class CalendarDay < ApplicationRecord
  belongs_to :participant

  enum :status, {
    available: "available",
    selected: "selected",
    in_process: "in_process",
    purchased: "purchased"
  }

  validates :day, presence: true, numericality: { in: 1..31 }
  validates :amount, presence: true

  broadcasts_to ->(calendar_day) { [ calendar_day.participant, "calendar" ] }

  def selected_days
    CalendarDay.where(participant: participant, status: "selected")
  end
end
