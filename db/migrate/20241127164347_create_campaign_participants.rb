class CreateCampaignParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_participants do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: true
      t.string :unique_calendar_link

      t.timestamps
    end
  end
end
