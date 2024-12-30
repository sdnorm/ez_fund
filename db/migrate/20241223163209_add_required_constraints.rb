class AddRequiredConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :organizations, :name, false
    change_column_null :organizations, :settings, false
    change_column_null :campaigns, :name, false
    change_column_null :campaigns, :status, false
    change_column_null :campaigns, :settings, false
    change_column_null :campaign_participants, :first_name, false
    change_column_null :campaign_participants, :last_name, false
    change_column_null :campaign_participants, :unique_code, false
    change_column_null :calendars, :number, false
    change_column_null :calendar_days, :day_number, false
    change_column_null :calendar_days, :status, false
    change_column_null :organization_users, :role, false
  end
end
