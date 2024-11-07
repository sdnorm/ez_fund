class AddCampaignAndOrgReferencesToPurchases < ActiveRecord::Migration[8.0]
  def change
    add_reference :purchases, :campaign, null: false, foreign_key: true
    add_reference :purchases, :organization, null: false, foreign_key: true
  end
end
