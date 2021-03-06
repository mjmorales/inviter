# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171119032720) do

  create_table "invitations", force: :cascade do |t|
    t.string "inviter_type", null: false
    t.integer "inviter_id", null: false
    t.string "invitee_type", null: false
    t.integer "invitee_id", null: false
    t.string "invited_to_type", null: false
    t.integer "invited_to_id", null: false
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accepted_at", "declined_at"], name: "index_invitations_on_accepted_at_and_declined_at"
    t.index ["accepted_at"], name: "index_invitations_on_accepted_at"
    t.index ["declined_at"], name: "index_invitations_on_declined_at"
    t.index ["invited_to_type", "invited_to_id"], name: "index_invitations_on_invited_to_type_and_invited_to_id"
    t.index ["invitee_type", "invitee_id"], name: "index_invitations_on_invitee_type_and_invitee_id"
    t.index ["inviter_id", "inviter_type", "invitee_type", "invitee_id", "invited_to_id", "invited_to_type"], name: "unique_invitation_index", unique: true
    t.index ["inviter_type", "inviter_id"], name: "index_invitations_on_inviter_type_and_inviter_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_parties", force: :cascade do |t|
    t.integer "user_id"
    t.integer "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_user_parties_on_party_id"
    t.index ["user_id"], name: "index_user_parties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
