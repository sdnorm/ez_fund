class ChangeCalendarDaysDonorIdToNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :calendar_days, :donor_id, true
    remove_foreign_key :calendar_days, :donors
    add_foreign_key :calendar_days, :donors, on_delete: :restrict
  end
end
