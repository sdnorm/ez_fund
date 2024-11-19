class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :timeoutable,
         :omniauthable

  has_many :sessions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :organizations, through: :user_roles
  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id

  normalizes :email, with: ->(e) { e.strip.downcase }
  validates_uniqueness_of :email

  def owner?(organization)
    organization.owner == self
  end

  def admin?(organization)
    puts organization.inspect
    return true if owner?(organization)
    user_roles.exists?(organization: organization, role: "admin")
  end

  def member?(organization)
    user_roles.exists?(organization: organization)
  end
end
