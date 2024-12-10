class CalendarController < ApplicationController
  before_action :set_calendar_things
  before_action :set_calendar_day, only: [ :select, :deselect ]

  before_action :set_session

  # before_action :set_or_create_session, only: [ :select ]

  def main
    @current_calendar_session = CalendarSession.find_by(cookie_id: cookies[:calendar_session_cookie_id])
    @calendar_number = params[:calendar_number]&.to_i || 1
    @calendar_days = @campaign_participant.calendar_days.for_calendar(@calendar_number)

    # Create calendar days if needed
    ensure_calendar_days(@calendar_number)

    @selected_days = @campaign_participant.calendar_days.selected
    @total = @selected_days.sum(&:amount)

    @cookie_id = cookies[:calendar_session_cookie_id]

    # Check if we need to show a link to a new calendar
    @show_new_calendar_link = CalendarDay.need_new_calendar?(@campaign_participant.id, @calendar_number)
    @next_calendar_number = @calendar_number + 1 if @show_new_calendar_link
  end

  def index
    @total = @calendar.total_of_selected_days
  end

  def select
    # check to see if the calendar_session_cookie_id exists, if not, create it
    if cookies[:calendar_session_cookie_id].blank?
      cookies[:calendar_session_cookie_id] = SecureRandom.uuid
      CalendarSession.create(
        cookie_id: cookies[:calendar_session_cookie_id],
        campaign_participant: @campaign_participant
      )
    end

    @cookie_id = cookies[:calendar_session_cookie_id]
    # store the cookie in a calendar_session record

    # store the cookie id in the calendar_day record
    @calendar_day.update(cookie_id: cookies[:calendar_session_cookie_id])

    @calendar_day.mark_as_selected

    @total = @calendar.total_of_selected_days
    respond_to do |format|
      format.turbo_stream
    end
  end

  def deselect
    @calendar_day.mark_as_available

    @total = @calendar.total_of_selected_days
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_calendar_things
    @campaign_participant = CampaignParticipant.includes(:participant, :calendar_days).find_by(unique_calendar_link: params[:code])
    @calendar = @campaign_participant.calendars.current
    @participant = @campaign_participant.participant
    @calendar_days = @calendar.calendar_days.order(:day)
    @your_selected_days = @calendar_days.selected_days_for_calendar_session(cookies[:calendar_session_cookie_id])
    @other_selected_days = @calendar_days.selected_days_not_in_calendar_session(cookies[:calendar_session_cookie_id])
    @selected_days = @calendar.selected_days
  end

  def set_calendar_day
    @calendar_day = @calendar_days.find_by(day: params[:selected_day])
  end

  def set_session
    # check if calendar_cookie_session_id exists, if not, create it
    # if session[:calendar_session_cookie_id].blank?
    #   session[:calendar_session_cookie_id] = SecureRandom.uuid
    # end
    # @calendar_session = CalendarSession.find_or_create_by(
    #   cookie_id: "#{session[:calendar_cookie_id]}",
    #   campaign_participant: @campaign_participant
    # ) do |cs|
    #   cs.expires_at = 4.minutes.from_now
    # end
    # @calendar_session.extend_session_if_expired

    @current_calendar_session_id = cookies[:calendar_session_cookie_id]
  end
end
