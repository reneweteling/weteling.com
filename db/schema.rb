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

ActiveRecord::Schema.define(version: 20170824121536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", id: :bigint, default: nil, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.string "author_type", limit: 255
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "date"
    t.text "content"
    t.string "image"
    t.boolean "published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs_tags", force: :cascade do |t|
    t.bigint "blog_id"
    t.bigint "tag_id"
    t.index ["blog_id"], name: "index_blogs_tags_on_blog_id"
    t.index ["tag_id"], name: "index_blogs_tags_on_tag_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "clients", id: :integer, default: nil, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 255, null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "department", limit: 255
    t.string "address", limit: 255
    t.string "postalcode", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "email", limit: 255
    t.string "iban", limit: 255
    t.string "bic", limit: 255
    t.string "iban_name", limit: 255
    t.string "coc_no", limit: 255
    t.string "tax_no", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "default_rate_id"
    t.index ["default_rate_id"], name: "index_clients_on_default_rate_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", id: :integer, default: nil, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "rate_id", null: false
    t.date "date", null: false
    t.decimal "total_hours", precision: 4, scale: 2, null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "total_sno_hours", precision: 4, scale: 2, null: false
    t.index ["project_id"], name: "index_hours_on_project_id"
    t.index ["rate_id"], name: "index_hours_on_rate_id"
  end

  create_table "projects", id: :integer, default: nil, force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", limit: 255, null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "projects_users", id: :bigint, default: nil, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "rates", id: :integer, default: nil, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 255, null: false
    t.text "description"
    t.decimal "rate", precision: 5, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "tag_id"
    t.index ["tag_id"], name: "index_tags_on_tag_id"
  end

  create_table "users", id: :integer, default: nil, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "department", limit: 255
    t.string "address", limit: 255
    t.string "postalcode", limit: 255
    t.string "city", limit: 255
    t.string "country", limit: 255
    t.string "email", limit: 255, null: false
    t.string "iban", limit: 255
    t.string "bic", limit: 255
    t.string "iban_name", limit: 255
    t.string "coc_no", limit: 255
    t.string "tax_no", limit: 255
    t.string "encrypted_password", limit: 255, null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blogs_tags", "blogs"
  add_foreign_key "blogs_tags", "tags"
  add_foreign_key "clients", "users"
  add_foreign_key "hours", "projects"
  add_foreign_key "hours", "rates"
  add_foreign_key "projects", "clients"
  add_foreign_key "rates", "users"
  add_foreign_key "tags", "tags"
end
