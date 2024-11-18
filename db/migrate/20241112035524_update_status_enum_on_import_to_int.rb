class UpdateStatusEnumOnImportToInt < ActiveRecord::Migration[8.0]
  def change
    change_column :imports, :status, :integer, using: "status::integer"
  end
end
