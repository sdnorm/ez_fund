class RemoveEmailAddressFromUsersTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :email_address
  end
end
