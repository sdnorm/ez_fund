class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :contact_email
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
