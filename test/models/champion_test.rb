# == Schema Information
#
# Table name: champions
#
#  id            :bigint           not null, primary key
#  first_name    :string
#  last_name     :string
#  email_address :string
#  campaign_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class ChampionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
