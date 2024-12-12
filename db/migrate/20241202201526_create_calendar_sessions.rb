class CreateCalendarSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :calendar_sessions do |t|
      t.string :cookie_id
      t.references :campaign_participant, null: false, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
    add_index :calendar_sessions, :cookie_id
  end
end
