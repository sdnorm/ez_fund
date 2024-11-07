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
require "test_helper"

class PurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
