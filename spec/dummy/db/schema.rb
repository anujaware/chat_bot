# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170714043950) do

  create_table "chat_bot_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chat_bot_categories", ["slug"], name: "index_chat_bot_categories_on_slug", unique: true

  create_table "chat_bot_conversations", force: :cascade do |t|
    t.string   "aasm_state"
    t.integer  "viewed_count"
    t.datetime "scheduled_at"
    t.integer  "priority"
    t.integer  "sub_category_id"
    t.integer  "dialog_id",       null: false
    t.integer  "created_for_id",  null: false
    t.integer  "option_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "chat_bot_conversations", ["created_for_id"], name: "index_chat_bot_conversations_on_created_for_id"
  add_index "chat_bot_conversations", ["dialog_id"], name: "index_chat_bot_conversations_on_dialog_id"

  create_table "chat_bot_dialogs", force: :cascade do |t|
    t.string   "code"
    t.string   "message"
    t.string   "user_input_type"
    t.string   "message_type"
    t.integer  "repeat_limit"
    t.integer  "sub_category_id"
    t.string   "slug",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "chat_bot_dialogs", ["slug"], name: "index_chat_bot_dialogs_on_slug"

  create_table "chat_bot_options", force: :cascade do |t|
    t.string   "name"
    t.string   "interval"
    t.boolean  "deprecated"
    t.integer  "dialog_id"
    t.integer  "decision_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "chat_bot_sub_categories", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "description"
    t.boolean  "approval_require",     default: true
    t.integer  "priority",             default: 1
    t.string   "starts_on_key",                        null: false
    t.string   "starts_on_val"
    t.boolean  "is_ready_to_schedule", default: false
    t.integer  "category_id",          default: 0
    t.integer  "initial_dialog_id"
    t.string   "slug",                                 null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "chat_bot_sub_categories", ["slug"], name: "index_chat_bot_sub_categories_on_slug", unique: true

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

end
