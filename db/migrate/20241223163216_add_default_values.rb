class AddDefaultValues < ActiveRecord::Migration[8.0]
  def change
    change_column_default :organizations, :settings, from: nil, to: {}
    change_column_default :campaigns, :settings, from: nil, to: {}
    change_column_default :campaigns, :status, from: nil, to: 0  # draft status
    change_column_default :calendar_days, :status, from: nil, to: 0  # available status
    change_column_default :organization_users, :role, from: nil, to: 0  # default role
  end
end
