class Campaign < ApplicationRecord
  acts_as_tenant(:organization)
  # Relationships
  belongs_to :organization
  has_many :champion_assignments, dependent: :destroy
  has_many :champions, through: :champion_assignments, source: :user
  has_many :campaign_participants, dependent: :destroy

  # Enums
  enum :status, {
    draft: 0,
    active: 1,
    completed: 2,
    cancelled: 3
  }
end
