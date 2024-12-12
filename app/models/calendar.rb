class Calendar < ApplicationRecord
  belongs_to :campaign_participant
  has_many :calendar_days


  before_create :set_calendar_number

  def set_calendar_number
    unless self.campaign_participant.calendars.empty?
      self.calendar_number = self.campaign_participant.calendars.last.calendar_number + 1
    end
  end

  after_create :create_calendar_days

  def create_calendar_days
    (1..31).each do |day|
      CalendarDay.create(
        calendar: self,
        day: day,
        amount: day,
        status: "available",
        campaign_participant: self.campaign_participant
      )
    end
  end

  # ensure there are only 31 calendar days

  scope :current, -> { order(calendar_number: :desc).first }

  def selected_days
    calendar_days.selected.order(:day)
  end

  def total_of_selected_days
    selected_days.sum(&:amount)
  end

  def total_of_selected_days_for_calendar_session(cookie_id)
    calendar_days.selected_days_for_calendar_session(cookie_id).sum(&:amount)
  end

  def purchased_days
    calendar_days.purchased
  end
end
