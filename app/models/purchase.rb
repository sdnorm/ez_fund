class Purchase < ApplicationRecord
  belongs_to :donor
  has_many :calendar_days

  after_create :mark_calendar_days_as_purchased

  private

  def mark_calendar_days_as_purchased
    calendar_days.update_all(status: :purchased, purchased_at: Time.current)
  end
end
