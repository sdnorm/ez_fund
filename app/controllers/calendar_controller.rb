class CalendarController < ApplicationController
  before_action :set_calendar_things
  before_action :set_calendar_day, only: [ :select, :deselect ]

  before_action :set_session, only: [ :index, :select, :deselect ]

  # before_action :set_or_create_session, only: [ :select ]

  def main
    # is calendar_session_cookie_id set?
    if cookies[:calendar_session_cookie_id].blank?
      cookies[:calendar_session_cookie_id] = SecureRandom.uuid
      CalendarSession.create(
        cookie_id: cookies[:calendar_session_cookie_id],
        campaign_participant: @campaign_participant
      )
    else
      @current_calendar_session = CalendarSession.find_by(cookie_id: cookies[:calendar_session_cookie_id])
    end

    @calendar_number = params[:calendar_number]&.to_i || 1
    # @calendar_days = @campaign_participant.calendar_days.for_calendar(@calendar_number)

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
    puts " "
    puts "cookei id: #{@cookie_id}"
    puts " "
    @total = @calendar.total_of_selected_days_for_calendar_session(@cookie_id)
    @calendar_stream_name = "calendar_#{@calendar.id}"
  end

  def select
    show_alert = true
    unless @calendar_day.selected?
      show_alert = false
      @cookie_id = cookies[:calendar_session_cookie_id]
      @calendar_day.update(
        cookie_id: @cookie_id,
        selected_at: Time.current
      )
      @calendar_day.mark_as_selected

      # Schedule the automatic deselection after 4 minutes
      CalendarDayCleanupJob.set(wait: 4.minutes).perform_later(@calendar_day.id)
    end

    @total = @calendar.total_of_selected_days_for_calendar_session(@cookie_id)
    respond_to do |format|
      flash.now[:alert] = "Day already selected!" if show_alert
      format.turbo_stream
    end
  end

  def deselect
    @calendar_day.mark_as_available

    @total = @calendar.total_of_selected_days_for_calendar_session(@cookie_id)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_calendar_things
    @campaign_participant = CampaignParticipant.includes(:participant, :calendar_days).find_by(unique_calendar_link: params[:code])
    if @campaign_participant.blank?
      redirect_to root_path, alert: "Calendar not found!"
    else
      @calendar = @campaign_participant.calendars.current
      @participant = @campaign_participant.participant
      @calendar_days = @calendar.calendar_days.order(:day)
      @your_selected_days = @calendar_days.selected_days_for_calendar_session(cookies[:calendar_session_cookie_id])
      @other_selected_days = @calendar_days.selected_days_not_in_calendar_session(cookies[:calendar_session_cookie_id])
      @selected_days = @your_selected_days
    end
  end

  def set_calendar_day
    @calendar_day = @calendar_days.find_by(day: params[:selected_day])
  end

  def set_session
    unless cookies[:calendar_session_cookie_id].present?
      cookies[:calendar_session_cookie_id] = SecureRandom.uuid
      CalendarSession.create!(
        cookie_id: cookies[:calendar_session_cookie_id],
        campaign_participant: @campaign_participant,
        expires_at: 4.minutes.from_now
      )
    end
    @cookie_id = cookies[:calendar_session_cookie_id]
    @current_calendar_session = CalendarSession.find_by(cookie_id: cookies[:calendar_session_cookie_id])
  end
end
