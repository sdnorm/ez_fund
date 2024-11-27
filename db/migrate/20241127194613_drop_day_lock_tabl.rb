class DropDayLockTabl < ActiveRecord::Migration[8.0]
  def change
    drop_table :day_locks
  end
end
