class Organization < ApplicationRecord
  # Relationships
  belongs_to :owner, class_name: "User"
  has_many :organization_users, dependent: :destroy
  has_many :users, through: :organization_users
  has_many :campaigns, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  # Callbacks
  before_validation :set_slug, if: :name_changed?

  pay_merchant

  # Add a method to calculate the platform fee
  def platform_fee_percentage
    # This could be dynamic based on referral or other conditions
    6.0
  end

  private

  def set_slug
    self.slug = name.parameterize
  end
end
