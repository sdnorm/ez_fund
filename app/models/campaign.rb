# == Schema Information
#
# Table name: campaigns
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  start_date      :datetime         not null
#  end_date        :datetime         not null
#  name            :string           not null
#  description     :text
#  active          :boolean          default(TRUE)
#  commission_rate :decimal(, )      default(5.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  goal            :decimal(, )
#
class Campaign < ApplicationRecord
  belongs_to :organization
  has_many :purchases

  def total_money_raised
    purchases.sum(:amount)
  end

  def progress
    (total_money_raised / goal) * 100 unless goal.nil? || goal == 0
  end
end
