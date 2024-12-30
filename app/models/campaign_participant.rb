class CampaignParticipant < ApplicationRecord
  belongs_to :campaign
  belongs_to :champion_assignment
  has_many :calendars, dependent: :destroy

  before_validation :generate_unique_code, on: :create

  private

  def generate_unique_code
    loop do
      self.unique_code = SecureRandom.alphanumeric(8).upcase
      break unless self.class.exists?(unique_code: unique_code)
    end
  end
end
