class Campaign < ApplicationRecord
  belongs_to :organization
  has_many :purchases

  def total_money_raised
    purchases.sum(:amount)
  end

  def percentage_raised
    (total_money_raised / goal) * 100
  end
end
