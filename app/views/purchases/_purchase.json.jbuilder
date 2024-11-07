json.extract! purchase, :id, :participant_id, :donor_id, :amount, :status, :stripe_transaction_id, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
