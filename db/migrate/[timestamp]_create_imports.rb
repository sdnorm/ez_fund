class CreateImports < ActiveRecord::Migration[7.1]
  def change
    create_table :imports do |t|
      t.references :campaign, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :total_rows, default: 0
      t.integer :successful_rows, default: 0
      t.jsonb :error_details, default: []

      t.timestamps
    end
  end
end 