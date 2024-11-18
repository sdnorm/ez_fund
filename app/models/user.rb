class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :timeoutable,
         :omniauthable
  # has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :organizations, through: :user_roles
  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id

  normalizes :email, with: ->(e) { e.strip.downcase }
  validates_uniqueness_of :email

  def owner?(org)
    user_roles.find_by(organization: org)&.role == "owner"
  end

  def admin?(org)
    user_roles.find_by(organization: org)&.role.in?(%w[owner admin])
  end

  def member?(org)
    user_roles.find_by(organization: org).present?
  end
end
