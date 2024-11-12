# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string           not null
#  last_name       :string           not null
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :organizations, through: :user_roles

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id
  # has_many :organizations

  acts_as_tenant(:organization)

  validates :email, uniqueness: { scope: :organization_id }

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
