class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :stripe_connect_id
      t.json :settings
      t.string :time_zone
      t.string :slug

      t.timestamps
    end
    add_index :organizations, :time_zone
    add_index :organizations, :slug, unique: true
  end
end
