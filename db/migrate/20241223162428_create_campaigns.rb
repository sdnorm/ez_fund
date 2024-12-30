class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.json :settings

      t.timestamps
    end
  end
end
