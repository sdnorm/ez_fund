class RemoveCampaignFromParticipant < ActiveRecord::Migration[8.0]
  def change
    change_column_null :participants, :campaign_id, true

    remove_reference :participants, :campaign, index: true, foreign_key: true
  end
end
