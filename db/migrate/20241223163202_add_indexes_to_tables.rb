class AddIndexesToTables < ActiveRecord::Migration[8.0]
  def change
    add_index :donors, :email
    add_index :organization_users, [ :organization_id, :user_id ], unique: true
    add_index :champion_assignments, [ :campaign_id, :user_id ], unique: true
    add_index :calendar_days, [ :calendar_id, :day_number ], unique: true
    add_index :purchases, :stripe_payment_intent_id, unique: true
    add_index :users, [ :provider, :uid ], unique: true, where: "provider IS NOT NULL AND uid IS NOT NULL"
  end
end
