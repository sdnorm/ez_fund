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

ActiveRecord::Schema[8.0].define(version: 2024_11_12_032700) do
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
    t.string "status"
    t.text "error_message"
    t.bigint "import_count"
    t.string "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_imports_on_campaign_id"
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
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
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

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "campaigns", "organizations"
  add_foreign_key "champions", "campaigns"
  add_foreign_key "imports", "campaigns"
  add_foreign_key "organizations", "users", column: "owner_id"
  add_foreign_key "participants", "campaigns"
  add_foreign_key "participants", "champions"
  add_foreign_key "purchases", "campaigns"
  add_foreign_key "purchases", "donors"
  add_foreign_key "purchases", "organizations"
  add_foreign_key "purchases", "participants"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_roles", "organizations"
  add_foreign_key "user_roles", "users"
end
