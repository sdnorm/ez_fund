class AddNotNullToOrganization < ActiveRecord::Migration[8.0]
  def change
    change_column_null :organizations, :subdomain, false
  end
end
