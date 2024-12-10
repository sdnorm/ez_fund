class RemoveUniqueCalendarLinkFromCampaignParticipantAndAddItToCalendar < ActiveRecord::Migration[8.0]
  def change
    remove_index :campaign_participants, :unique_calendar_link
    remove_column :campaign_participants, :unique_calendar_link
  end
end
