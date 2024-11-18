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

  before_create :set_subdomain

  def set_subdomain
    self.subdomain = name.parameterize
  end

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

  def admins
    user_roles.where(role: %w[owner admin]).includes(:user).map(&:user)
  end

  def members
    users
  end
end
