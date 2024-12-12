module CalendarHelper
  def calendar_day_status_class(calendar_day)
    base_classes = "transition-colors duration-200"

    status = if calendar_day.purchased?
      "purchased"
    elsif calendar_day.selected? && calendar_day.cookie_id == cookies[:calendar_session_cookie_id]
      "selected"
    elsif calendar_day.selected?
      "other_selected"
    else
      "available"
    end

    status_classes = {
      "available" => "bg-white hover:bg-gray-50 cursor-pointer",
      "selected" => "bg-blue-100 hover:bg-blue-200 cursor-pointer",
      "other_selected" => "bg-yellow-100 cursor-not-allowed",
      "purchased" => "bg-green-100 cursor-not-allowed"
    }

    "#{base_classes} #{status_classes[status]}"
  end

  def display_day_status(day)
    # case day.status
    # when "selected"
    #   "Selected"
    # when "pending"
    #   "Pending"
    # when "confirmed"
    #   "Confirmed"
    # else
    #   ""
    # end
  end
end
