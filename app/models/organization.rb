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
#
class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :campaigns, dependent: :destroy
  accepts_nested_attributes_for :campaigns
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
