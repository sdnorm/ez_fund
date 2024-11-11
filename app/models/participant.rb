# == Schema Information
#
# Table name: participants
#
#  id                   :bigint           not null, primary key
#  first_name           :string
#  last_name            :string
#  teacher              :string
#  unique_calendar_link :string
#  campaign_id          :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Participant < ApplicationRecord
  belongs_to :campaign
  belongs_to :champion, optional: true

  def total_money_raised
    purchases.successful_campaign_purchases.sum(:amount)
  end
end
