class AddCalendarNumberAndIndexToCalendarDay < ActiveRecord::Migration[8.0]
  def change
    add_column :calendar_days, :calendar_number, :integer, default: 1
    add_index :calendar_days, [ :campaign_participant_id, :calendar_number, :day ], unique: true, name: "unique_day_per_calendar"
  end
end
