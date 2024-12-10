module CalendarHelper
  def calendar_day_status_class(calendar_day_status, current_calendar_session: nil)
    return "" unless calendar_day_status

    case calendar_day_status
    when "purchased"
      "bg-gray-200 cursor-not-allowed"
    when "selected" && current_calendar_session.present?
      "bg-yellow-100"
    when "in_process"
    else
      ""
    end
  end
end
