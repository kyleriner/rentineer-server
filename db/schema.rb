# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_15_162925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.string "unit"
    t.integer "price"
  end

  create_table "images", force: :cascade do |t|
    t.integer "property_id"
    t.string "image"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.integer "price_min"
    t.integer "price_max"
    t.string "address"
    t.string "zip"
    t.string "phone"
    t.boolean "dog_friendly"
    t.boolean "cat_friendly"
    t.string "neighborhood"
    t.integer "year_built"
  end

  create_table "property_apartments", force: :cascade do |t|
    t.integer "property_id"
    t.integer "apartment_id"
  end

  create_table "user_properties", force: :cascade do |t|
    t.integer "user_id"
    t.integer "property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
