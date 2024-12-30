class OrganizationUser < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  enum :role, {
    admin: 0,
    champion: 1
  }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }
end
