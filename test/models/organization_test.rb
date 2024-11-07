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
require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
