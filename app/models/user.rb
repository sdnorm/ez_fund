class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id
  # has_many :organizations
end
