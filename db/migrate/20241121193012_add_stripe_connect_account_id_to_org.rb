class AddStripeConnectAccountIdToOrg < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :stripe_connect_account_id, :string
    add_index :organizations, :stripe_connect_account_id
  end
end
