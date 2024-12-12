class CampaignChampion < ApplicationRecord
  belongs_to :champion
  belongs_to :campaign
end
