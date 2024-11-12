# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  name          :string
#  address_1     :string
#  address_2     :string
#  city          :string
#  state         :string
#  contact_email :string
#  owner_id      :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  time_zone     :string
#  subdomain     :string
#
class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :campaigns, dependent: :destroy
  has_many :purchases
  has_many :donors, through: :purchases
  has_one_attached :logo

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  def total_money_raised
    purchases.sum(:amount)
  end

  def donors_count
    donors.distinct.count
  end

  def recent_activities
    purchases.order(created_at: :desc).limit(10)
  end

  has_one_attached :logo

  def owner
    user_roles.find_by(role: "owner")&.user
  end

  def admins
    user_roles.where(role: %w[owner admin]).includes(:user).map(&:user)
  end

  def members
    users
  end
end
