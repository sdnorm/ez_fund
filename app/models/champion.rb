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
class Champion < ApplicationRecord
  belongs_to :campaign

  has_many :participants

  def name
    "#{first_name} #{last_name}"
  end
end
