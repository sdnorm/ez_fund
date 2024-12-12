class CalendarDayCleanupJob < ApplicationJob
  queue_as :default

  def perform(calendar_day_id)
    calendar_day = CalendarDay.find_by(id: calendar_day_id)
    return unless calendar_day
    return unless calendar_day.selected?
    return unless calendar_day.selected_at < 4.minutes.ago

    calendar_day.mark_as_available
  end
end
