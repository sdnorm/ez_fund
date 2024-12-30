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

ActiveRecord::Schema[8.0].define(version: 2024_12_23_184400) do
  create_table "calendar_days", force: :cascade do |t|
    t.integer "calendar_id", null: false
    t.integer "day_number", null: false
    t.integer "status", default: 0, null: false
    t.integer "donor_id"
    t.datetime "selected_at"
    t.datetime "purchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id", "day_number"], name: "index_calendar_days_on_calendar_id_and_day_number", unique: true
    t.index ["calendar_id"], name: "index_calendar_days_on_calendar_id"
    t.index ["donor_id"], name: "index_calendar_days_on_donor_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer "campaign_participant_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_participant_id"], name: "index_calendars_on_campaign_participant_id"
  end

  create_table "campaign_participants", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.integer "champion_assignment_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "unique_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_participants_on_campaign_id"
    t.index ["champion_assignment_id"], name: "index_campaign_participants_on_champion_assignment_id"
    t.index ["unique_code"], name: "index_campaign_participants_on_unique_code", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.string "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "status", default: 0, null: false
    t.json "settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
  end

  create_table "champion_assignments", force: :cascade do |t|
    t.integer "campaign_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id", "user_id"], name: "index_champion_assignments_on_campaign_id_and_user_id", unique: true
    t.index ["campaign_id"], name: "index_champion_assignments_on_campaign_id"
    t.index ["user_id"], name: "index_champion_assignments_on_user_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_donors_on_email"
  end

  create_table "organization_users", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "user_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "user_id"], name: "index_organization_users_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "stripe_connect_id"
    t.json "settings", default: {}, null: false
    t.string "time_zone"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
    t.index ["time_zone"], name: "index_organizations_on_time_zone"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "donor_id", null: false
    t.decimal "amount", null: false
    t.string "stripe_payment_intent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donor_id"], name: "index_purchases_on_donor_id"
    t.index ["stripe_payment_intent_id"], name: "index_purchases_on_stripe_payment_intent_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_organization_id"
    t.index ["current_organization_id"], name: "index_users_on_current_organization_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, where: "provider IS NOT NULL AND uid IS NOT NULL"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calendar_days", "calendars"
  add_foreign_key "calendar_days", "donors", on_delete: :restrict
  add_foreign_key "calendars", "campaign_participants"
  add_foreign_key "campaign_participants", "campaigns"
  add_foreign_key "campaign_participants", "champion_assignments"
  add_foreign_key "campaigns", "organizations"
  add_foreign_key "champion_assignments", "campaigns"
  add_foreign_key "champion_assignments", "users"
  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "purchases", "donors"
end
