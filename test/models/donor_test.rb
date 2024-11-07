# == Schema Information
#
# Table name: donors
#
#  id                 :bigint           not null, primary key
#  first_name         :string           not null
#  last_name          :string
#  email_address      :string           not null
#  stripe_customer_id :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class DonorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
