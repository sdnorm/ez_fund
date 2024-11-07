class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.references :organization, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true
      t.decimal :commission_rate, default: 5.0, null: false

      t.timestamps
    end
  end
end
