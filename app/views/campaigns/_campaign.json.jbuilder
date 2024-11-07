json.extract! campaign, :id, :organization_id, :start_date, :end_date, :name, :description, :active, :commission_rate, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
