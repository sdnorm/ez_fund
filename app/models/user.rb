class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2, :office365 ]

  # Relationships
  has_many :organization_users, dependent: :destroy
  has_many :organizations, through: :organization_users
  has_many :champion_assignments, dependent: :destroy
  has_many :campaigns, through: :champion_assignments

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def switch_organization(organization)
    return false unless organizations.include?(organization)

    update(current_organization_id: organization.id)
  end

  def current_organization
    return organizations.first if current_organization_id.nil? && organizations.any?
    return Organization.find_by(id: current_organization_id) if current_organization_id.present?
    nil
  end

  def admin?(organization)
    organization_users.exists?(organization: organization, role: :admin)
  end
end
