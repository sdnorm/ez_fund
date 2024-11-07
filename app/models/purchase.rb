# == Schema Information
#
# Table name: purchases
#
#  id                    :bigint           not null, primary key
#  participant_id        :bigint           not null
#  donor_id              :bigint           not null
#  amount                :bigint
#  status                :bigint
#  stripe_transaction_id :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  campaign_id           :bigint           not null
#  organization_id       :bigint           not null
#
class Purchase < ApplicationRecord
  belongs_to :participant
  belongs_to :donor
  belongs_to :campaign
  belongs_to :organization

  delegate :amount, to: :campaign
  delegate :amount, to: :organization
end
