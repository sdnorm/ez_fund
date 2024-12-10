class AddCookieIdBackToCalendarDay < ActiveRecord::Migration[8.0]
  def change
    add_column :calendar_days, :cookie_id, :string

    add_index :calendar_days, :cookie_id
  end
end
