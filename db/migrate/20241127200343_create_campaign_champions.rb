class CreateCampaignChampions < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_champions do |t|
      t.references :champion, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
