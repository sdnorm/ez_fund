class ReworkTheCodeForTheCalendarAgain < ActiveRecord::Migration[8.0]
  def change
    remove_index :calendars, :code
    remove_column :calendars, :code

    add_column :campaign_participants, :unique_calendar_link, :string
    add_index :campaign_participants, :unique_calendar_link, unique: true
  end
end
