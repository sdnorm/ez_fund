class AddSelectedDaysArrayAndCookieIdToCalendarDays < ActiveRecord::Migration[8.0]
  def change
    # add_column :calendar_days, :selected_days, :integer, array: true, default: []
    # add_column :calendar_days, :cookie_id, :string
  end
end
