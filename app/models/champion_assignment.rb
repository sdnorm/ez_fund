class ChampionAssignment < ApplicationRecord
  belongs_to :campaign
  belongs_to :user

  has_many :campaign_participants, dependent: :destroy

  scope :for_organization, ->(organization) { joins(:campaign).where(campaigns: { organization_id: organization.id }) }
end
