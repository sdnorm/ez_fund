class CreateImports < ActiveRecord::Migration[8.0]
  def change
    create_table :imports do |t|
      t.references :campaign, null: false, foreign_key: true
      t.string :status
      t.text :error_message
      t.bigint :import_count
      t.string :filename

      t.timestamps
    end
  end
end
