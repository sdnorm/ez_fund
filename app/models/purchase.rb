class Purchase < ApplicationRecord
  belongs_to :donor
  belongs_to :calendar_day

  # Calculate the platform fee and organization's portion
  def calculate_fees
    platform_fee = amount * (calendar_day.campaign_participant.campaign.organization.platform_fee_percentage / 100.0)
    organization_portion = amount - platform_fee
    { platform_fee: platform_fee, organization_portion: organization_portion }
  end
end
