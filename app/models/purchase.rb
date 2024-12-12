class Purchase < ApplicationRecord
  belongs_to :participant
  belongs_to :donor
  belongs_to :campaign
  belongs_to :organization

  delegate :amount, to: :campaign
  delegate :amount, to: :organization

  scope :successful_campaign_purchases, ->(campaign) { where(status: "completed", campaign: campaign) }

  def successful?
    status == "completed" # adjust based on your actual status values
  end
end
