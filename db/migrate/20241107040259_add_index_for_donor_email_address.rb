class AddIndexForDonorEmailAddress < ActiveRecord::Migration[8.0]
  def change
    add_index :donors, :email_address, unique: true
  end
end
