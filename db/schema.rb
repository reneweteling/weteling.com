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

ActiveRecord::Schema.define(version: 2018_02_15_075805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
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

  create_table "clients", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "department"
    t.string "address"
    t.string "postalcode"
    t.string "city"
    t.string "country"
    t.string "email"
    t.string "iban"
    t.string "bic"
    t.string "iban_name"
    t.string "coc_no"
    t.string "tax_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "hours", id: :serial, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "rate_id", null: false
    t.date "date", null: false
    t.decimal "total_hours", precision: 4, scale: 2, default: "0.0", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_sno_hours", precision: 4, scale: 2, default: "0.0", null: false
    t.index ["project_id"], name: "index_hours_on_project_id"
    t.index ["rate_id"], name: "index_hours_on_rate_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.integer "pagetype", default: 0, null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "subtitle"
    t.date "start_date"
    t.date "end_date"
    t.boolean "show", default: false, null: false
    t.integer "position", default: 0, null: false
    t.string "image"
    t.text "description_cv", default: "", null: false
    t.boolean "cv_active", default: false, null: false
    t.boolean "hours_active", default: false, null: false
    t.boolean "site_active", default: false, null: false
    t.text "description_about_the_company"
    t.text "description_my_role"
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "projects_tags", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "tag_id"
    t.index ["project_id"], name: "index_projects_tags_on_project_id"
    t.index ["tag_id"], name: "index_projects_tags_on_tag_id"
  end

  create_table "projects_users", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "rates", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.text "description"
    t.decimal "rate", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "tag_id"
    t.index ["tag_id"], name: "index_tags_on_tag_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "department"
    t.string "address"
    t.string "postalcode"
    t.string "city"
    t.string "country"
    t.string "email", default: "", null: false
    t.string "iban"
    t.string "bic"
    t.string "iban_name"
    t.string "coc_no"
    t.string "tax_no"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
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
