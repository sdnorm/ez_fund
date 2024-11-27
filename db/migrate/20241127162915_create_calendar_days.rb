class CreateCalendarDays < ActiveRecord::Migration[8.0]
  def change
    drop_table :calendar_days
    create_table :calendar_days do |t|
      t.references :participant, null: false, foreign_key: true
      t.integer :day
      t.decimal :amount, precision: 8, scale: 2
      t.string :status
      t.string :purchaser_name
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
