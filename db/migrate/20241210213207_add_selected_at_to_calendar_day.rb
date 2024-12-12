class AddSelectedAtToCalendarDay < ActiveRecord::Migration[8.0]
  def change
    add_column :calendar_days, :selected_at, :datetime
    add_index :calendar_days, :selected_at
  end
end
