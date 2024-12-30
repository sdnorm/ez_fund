class CreateDonors < ActiveRecord::Migration[8.0]
  def change
    create_table :donors do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
