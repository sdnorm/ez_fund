class AddCalendarNumberToCalendar < ActiveRecord::Migration[8.0]
  def change
    add_column :calendars, :calendar_number, :integer, default: 1
  end
end
