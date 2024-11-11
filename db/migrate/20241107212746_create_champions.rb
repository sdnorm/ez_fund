class CreateChampions < ActiveRecord::Migration[8.0]
  def change
    create_table :champions do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
