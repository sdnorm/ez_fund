class CreateParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :teacher
      t.string :unique_calendar_link
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
