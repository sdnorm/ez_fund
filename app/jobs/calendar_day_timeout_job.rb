class CalendarDayTimeoutJob < ApplicationJob
  queue_as :default

  def perform(calendar_day_id)
    calendar_day = CalendarDay.find_by(id: calendar_day_id)
    return unless calendar_day&.selected?

    calendar_day.update!(status: :available, selected_at: nil)
  end
end
