class CreateDonors < ActiveRecord::Migration[8.0]
  def change
    create_table :donors do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email_address, null: false
      t.string :stripe_customer_id

      t.timestamps
    end
  end
end
