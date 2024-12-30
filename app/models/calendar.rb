class Calendar < ApplicationRecord
  # Remove acts_as_tenant
  belongs_to :campaign_participant
  has_many :calendar_days, dependent: :destroy

  # Callbacks
  after_create :generate_calendar_days

  private

  def generate_calendar_days
    (1..31).each do |day_number|
      calendar_days.create!(day_number: day_number)
    end
  end
end
