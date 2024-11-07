class AddGoalToCampaign < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :goal, :decimal
  end
end
