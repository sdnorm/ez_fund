class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :campaigns, dependent: :destroy
  has_many :purchases
  has_many :donors, through: :purchases
  has_one_attached :logo

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
end
