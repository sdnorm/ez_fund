class AddOptionalChampionRelationToCampaignParticipant < ActiveRecord::Migration[8.0]
  def change
    add_reference :campaign_participants, :champion, null: true
  end
end
