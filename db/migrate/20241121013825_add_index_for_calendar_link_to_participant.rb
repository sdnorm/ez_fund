class AddIndexForCalendarLinkToParticipant < ActiveRecord::Migration[8.0]
  def change
    add_index :participants, :unique_calendar_link, unique: true
  end
end
