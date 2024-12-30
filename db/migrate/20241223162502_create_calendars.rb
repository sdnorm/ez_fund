class CreateCalendars < ActiveRecord::Migration[8.0]
  def change
    create_table :calendars do |t|
      t.references :campaign_participant, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
