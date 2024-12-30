class Organization < ApplicationRecord
  # Relationships
  has_many :organization_users, dependent: :destroy
  has_many :users, through: :organization_users
  has_many :campaigns, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  # Callbacks
  before_validation :set_slug, if: :name_changed?

  private

  def set_slug
    self.slug = name.parameterize
  end
end
