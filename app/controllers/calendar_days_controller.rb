class CalendarDaysController < ApplicationController
  before_action :set_calendar_day

  def select
    @calendar_day.update(status: :selected, selected_at: Time.current)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def unselect
    @calendar_day.update(status: :available, selected_at: nil)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_calendar_day
    @calendar_day = CalendarDay.find(params[:id])
  end
end
