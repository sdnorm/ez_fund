class CreateCampaignParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_participants do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :champion_assignment, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :unique_code

      t.timestamps
    end
    add_index :campaign_participants, :unique_code, unique: true
  end
end
