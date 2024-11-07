class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :donor, null: false, foreign_key: true
      t.bigint :amount
      t.bigint :status
      t.string :stripe_transaction_id

      t.timestamps
    end
  end
end
