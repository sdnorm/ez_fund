class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :donor, null: false, foreign_key: true
      t.decimal :amount
      t.string :stripe_payment_intent_id

      t.timestamps
    end
  end
end
