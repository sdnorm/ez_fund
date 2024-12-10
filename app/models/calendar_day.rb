class CalendarDay < ApplicationRecord
  belongs_to :campaign_participant
  belongs_to :calendar

  enum :status, {
    available: "available",
    selected: "selected",
    in_process: "in_process",
    purchased: "purchased"
  }

  validates :day, presence: true, numericality: { in: 1..31 }
  validates :amount, presence: true
  validates :day, uniqueness: { scope: [ :campaign_participant_id, :calendar_number ] }

  scope :for_calendar, ->(number) { where(calendar_number: number) }
  scope :selected_days, ->(campaign_participant:, status: "selected") {
    where(campaign_participant: campaign_participant, status: status)
  }
  scope :selected_days_for_calendar_session, ->(cookie_id) {
    where(cookie_id: cookie_id, status: "selected")
  }
  scope :selected_days_not_in_calendar_session, ->(cookie_id) {
    where.not(cookie_id: cookie_id, status: "selected")
  }

  scope :available_days, -> { where(status: :available) }
  scope :purchased_days, -> { where(status: :purchased) }

  belongs_to :calendar_session,
    foreign_key: :cookie_id,
    primary_key: :cookie_id,
    optional: true

  def selectable?
    available? && !expired?
  end

  def expired?
    selected? && selected_at < 4.minutes.ago
  end

  def owned_by?(session_id)
    cookie_id == session_id
  end

  def amount
    day.to_d
  end

  def mark_as_selected
    update!(status: :selected)
  end

  def mark_as_available
    update!(status: :available)
  end

  def self.need_new_calendar?(campaign_participant_id, calendar_number)
    where(campaign_participant_id: campaign_participant_id, calendar_number: calendar_number)
      .where(status: :purchased)
      .count >= 31
  end

  def self.next_calendar_number(campaign_participant_id)
    where(campaign_participant_id: campaign_participant_id)
      .maximum(:calendar_number)
      .to_i + 1
  end

  # Turbo Streams broadcasting for real-time updates
  # after_create_commit { broadcast_append_to calendar }
  # after_update_commit { broadcast_replace_to calendar }
  # after_update_commit { broadcast_replace_to calendar, partial: "calendar/calendar", locals: {
  #   calendar: self.calendar,
  #   calendar_days: self.calendar.calendar_days,
  #   calendar_day: self,
  #   campaign_participant: self.campaign_participant,
  #   campaign: self.campaign_participant.campaign
  # } }
  # after_update_commit { broadcast_replace_to calendar, partial: "calendar/calednar_day", locals: { calendar_day: self, campaign_participant: campaign_participant } }
  # after_destroy_commit { broadcast_remove_to calendar }
end
