class AddCurrentOrganizationIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_organization_id, :integer
    add_index :users, :current_organization_id
  end
end
