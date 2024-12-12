class SwitchThingsOverToCampaignChampions < ActiveRecord::Migration[8.0]
  def change
    remove_reference :participants, :campaign_participant, index: true

    remove_reference :champions, :campaign, index: true
  end
end
