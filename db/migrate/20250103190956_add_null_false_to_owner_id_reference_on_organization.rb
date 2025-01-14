class AddNullFalseToOwnerIdReferenceOnOrganization < ActiveRecord::Migration[8.0]
  def change
    change_column_null :organizations, :owner_id, false
  end
end
