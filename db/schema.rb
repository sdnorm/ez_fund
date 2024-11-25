# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_11_22_040424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.decimal "commission_rate", default: "5.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "goal"
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
  end

  create_table "champions", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.bigint "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_champions_on_campaign_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email_address", null: false
    t.string "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_donors_on_email_address", unique: true
  end

  create_table "imports", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.integer "status"
    t.text "error_message"
    t.bigint "import_count"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_imports_on_campaign_id"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.jsonb "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "contact_email"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone"
    t.string "subdomain", null: false
    t.string "stripe_connect_account_id"
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
    t.index ["stripe_connect_account_id"], name: "index_organizations_on_stripe_connect_account_id"
    t.index ["subdomain"], name: "index_organizations_on_subdomain", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "teacher"
    t.string "unique_calendar_link"
    t.bigint "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "champion_id"
    t.index ["campaign_id"], name: "index_participants_on_campaign_id"
    t.index ["champion_id"], name: "index_participants_on_champion_id"
    t.index ["unique_calendar_link"], name: "index_participants_on_unique_calendar_link", unique: true
  end

  create_table "pay_charges", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "subscription_id"
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.string "currency"
    t.integer "application_fee_amount"
    t.integer "amount_refunded"
    t.jsonb "metadata"
    t.jsonb "data"
    t.string "stripe_account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
    t.index ["subscription_id"], name: "index_pay_charges_on_subscription_id"
  end

  create_table "pay_customers", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.string "stripe_account"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["owner_type", "owner_id", "deleted_at"], name: "pay_customer_owner_index", unique: true
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id", unique: true
  end

  create_table "pay_merchants", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
  end

  create_table "pay_payment_methods", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "processor_id", null: false
    t.boolean "default"
    t.string "payment_method_type"
    t.jsonb "data"
    t.string "stripe_account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.string "status", null: false
    t.datetime "current_period_start", precision: nil
    t.datetime "current_period_end", precision: nil
    t.datetime "trial_ends_at", precision: nil
    t.datetime "ends_at", precision: nil
    t.boolean "metered"
    t.string "pause_behavior"
    t.datetime "pause_starts_at", precision: nil
    t.datetime "pause_resumes_at", precision: nil
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.jsonb "metadata"
    t.jsonb "data"
    t.string "stripe_account"
    t.string "payment_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
    t.index ["metered"], name: "index_pay_subscriptions_on_metered"
    t.index ["pause_starts_at"], name: "index_pay_subscriptions_on_pause_starts_at"
  end

  create_table "pay_webhooks", force: :cascade do |t|
    t.string "processor"
    t.string "event_type"
    t.jsonb "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "donor_id", null: false
    t.bigint "amount"
    t.bigint "status"
    t.string "stripe_transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_id", null: false
    t.bigint "organization_id", null: false
    t.index ["campaign_id"], name: "index_purchases_on_campaign_id"
    t.index ["donor_id"], name: "index_purchases_on_donor_id"
    t.index ["organization_id"], name: "index_purchases_on_organization_id"
    t.index ["participant_id"], name: "index_purchases_on_participant_id"
  end

  create_table "refer_referral_codes", force: :cascade do |t|
    t.string "referrer_type", null: false
    t.bigint "referrer_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referrals_count", default: 0
    t.integer "visits_count", default: 0
    t.index ["code"], name: "index_refer_referral_codes_on_code", unique: true
    t.index ["referrer_type", "referrer_id"], name: "index_refer_referral_codes_on_referrer"
  end

  create_table "refer_referrals", force: :cascade do |t|
    t.string "referrer_type", null: false
    t.bigint "referrer_id", null: false
    t.string "referee_type", null: false
    t.bigint "referee_id", null: false
    t.bigint "referral_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "completed_at", precision: nil
    t.index ["referee_type", "referee_id"], name: "index_refer_referrals_on_referee"
    t.index ["referral_code_id"], name: "index_refer_referrals_on_referral_code_id"
    t.index ["referrer_type", "referrer_id"], name: "index_refer_referrals_on_referrer"
  end

  create_table "refer_visits", force: :cascade do |t|
    t.bigint "referral_code_id", null: false
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referral_code_id"], name: "index_refer_visits_on_referral_code_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_organization_id"
    t.index ["last_organization_id"], name: "index_sessions_on_last_organization_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_user_roles_on_organization_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "last_organization_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["last_organization_id"], name: "index_users_on_last_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "campaigns", "organizations"
  add_foreign_key "champions", "campaigns"
  add_foreign_key "imports", "campaigns"
  add_foreign_key "organizations", "users", column: "owner_id"
  add_foreign_key "participants", "campaigns"
  add_foreign_key "participants", "champions"
  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_charges", "pay_subscriptions", column: "subscription_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
  add_foreign_key "purchases", "campaigns"
  add_foreign_key "purchases", "donors"
  add_foreign_key "purchases", "organizations"
  add_foreign_key "purchases", "participants"
  add_foreign_key "refer_visits", "refer_referral_codes", column: "referral_code_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_roles", "organizations"
  add_foreign_key "user_roles", "users"
end
