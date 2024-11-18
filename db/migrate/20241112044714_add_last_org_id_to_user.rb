class AddLastOrgIdToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_organization_id, :integer
    add_index :users, :last_organization_id
  end
end
