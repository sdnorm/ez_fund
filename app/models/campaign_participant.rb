class CampaignParticipant < ApplicationRecord
  belongs_to :campaign
  belongs_to :participant

  validates :unique_calendar_link, uniqueness: true

  before_create :generate_unique_calendar_link

  has_many :calendars
  has_many :calendar_days, through: :calendars

  def generate_unique_calendar_link
    max_attempts = 5
    attempt = 0
    begin
      attempt += 1
      self.unique_calendar_link = SecureRandom.uuid.delete("-")
      self.save!
    rescue ActiveRecord::RecordInvalid => e
      if attempt < max_attempts && e.record.errors.include?(:unique_calendar_link)
        Rails.logger.warn "Calendar link collision occurred (attempt #{attempt})"
        retry
      end
      raise e
    end
  end
end
