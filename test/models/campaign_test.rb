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
require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
