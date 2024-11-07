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
end
