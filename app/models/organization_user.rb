class OrganizationUser < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  enum :role, {
    member: 0,
    admin: 1,
    champion: 2
  }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }
end
