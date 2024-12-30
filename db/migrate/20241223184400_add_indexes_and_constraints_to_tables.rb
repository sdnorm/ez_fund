class AddIndexesAndConstraintsToTables < ActiveRecord::Migration[8.0]
  def change
    # Add NOT NULL constraints
    change_column_null :purchases, :amount, false
    change_column_null :purchases, :stripe_payment_intent_id, false
  end
end
