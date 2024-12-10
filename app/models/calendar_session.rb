class CalendarSession < ApplicationRecord
  belongs_to :campaign_participant
  has_many :calendar_days, foreign_key: :cookie_id, primary_key: :cookie_id

  validates :cookie_id, presence: true
  validates :cookie_id, uniqueness: { scope: :campaign_participant_id }
  validates :expires_at, presence: true

  scope :active, -> { where("expires_at > ?", Time.current) }
  scope :expired, -> { where("expires_at <= ?", Time.current) }

  def expired?
    expires_at <= Time.current
  end

  def selected_days
    calendar_days.selected
  end

  def release_selected_days!
    calendar_days.selected.update_all(
      status: :available,
      cookie_id: nil
    )
  end

  def extend_session_if_expired
    if expired?
      update(expires_at: 4.minutes.from_now)
    end
  end
end
