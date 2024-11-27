class Champion < ApplicationRecord
  has_many :campaign_champions
  has_many :campaigns, through: :campaign_champions

  has_many :campaign_participants

  def name
    "#{first_name} #{last_name}"
  end
end
