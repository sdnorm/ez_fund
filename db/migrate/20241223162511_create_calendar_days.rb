class CreateCalendarDays < ActiveRecord::Migration[8.0]
  def change
    create_table :calendar_days do |t|
      t.references :calendar, null: false, foreign_key: true
      t.integer :day_number
      t.integer :status
      t.references :donor, null: false, foreign_key: true
      t.datetime :selected_at
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
