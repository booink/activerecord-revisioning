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

ActiveRecord::Schema.define(version: 2018_09_02_010000) do

  create_table "article_revisions", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "associated_id"
    t.string "associated_type"
    t.string "behavior", null: false
    t.text "revision_changes"
    t.integer "version", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["article_id"], name: "index_article_revisions_on_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "content"
    t.integer "status"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "article_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "revisioning_revisions", force: :cascade do |t|
    t.integer "revisionable_id", null: false
    t.string "revisionable_type", null: false
    t.integer "associated_id"
    t.string "associated_type"
    t.string "behavior", null: false
    t.text "revision_changes"
    t.integer "version", default: 0, null: false
    t.datetime "created_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
