class CalendarDay < ApplicationRecord
  belongs_to :calendar
  belongs_to :donor, optional: true

  enum :status, {
    available: 0,
    selected: 1,
    purchased: 2
  }

  # After 4 minutes of being selected, automatically revert to available
  after_update_commit :schedule_selection_timeout, if: :selected?
  after_update_commit :broadcast_update

  private

  def schedule_selection_timeout
    return unless selected? && selected_at_previously_changed?

    CalendarDayTimeoutJob.set(wait: 4.minutes).perform_later(id)
  end

  def broadcast_update
    broadcast_replace_to calendar,
      partial: "calendar_days/calendar_day",
      locals: { calendar_day: self }
  end
end
