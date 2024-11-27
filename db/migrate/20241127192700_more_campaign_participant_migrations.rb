class MoreCampaignParticipantMigrations < ActiveRecord::Migration[8.0]
  def change
    change_column_null :campaign_participants, :unique_calendar_link, false

    add_index :campaign_participants, :unique_calendar_link, unique: true

    remove_reference :calendar_days, :participant, index: true
    add_reference :calendar_days, :campaign_participant, index: true

    remove_reference :participants, :champion, index: true
    add_reference :participants, :campaign_participant, index: true
    remove_column :participants, :unique_calendar_link, index: true
    remove_column :participants, :total_raised, type: :decimal, precision: 8, scale: 2
    remove_column :participants, :teacher
  end
end
