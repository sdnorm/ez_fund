module CalendarHelper
  def calendar_day_status_class(calendar_day)
    return "" unless calendar_day

    case calendar_day.status
    when "purchased"
      "bg-gray-200 cursor-not-allowed"
    when "in_process"
      "bg-yellow-100"
    else
      ""
    end
  end
end
