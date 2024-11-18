class AddOrganizationsToSession < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :last_organization_id, :integer
    add_index :sessions, :last_organization_id
  end
end
