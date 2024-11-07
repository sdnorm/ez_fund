class Purchase < ApplicationRecord
  belongs_to :participant
  belongs_to :donor
  belongs_to :campaign
  belongs_to :organization

  delegate :amount, to: :campaign
  delegate :amount, to: :organization
end
