class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  acts_as_tenant(:organization)

  ROLES = %w[admin member].freeze

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :organization_id }
end
