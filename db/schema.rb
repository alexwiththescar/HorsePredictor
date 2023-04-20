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

ActiveRecord::Schema[7.0].define(version: 2023_04_13_130634) do
  create_table "race_results", force: :cascade do |t|
    t.date "date"
    t.string "region"
    t.string "course"
    t.string "off"
    t.string "race_name"
    t.string "race_type"
    t.string "pattern"
    t.string "rating_band"
    t.string "age_band"
    t.string "sex_rest"
    t.integer "dist"
    t.integer "dist_f"
    t.integer "dist_m"
    t.string "going"
    t.integer "ran"
    t.integer "num"
    t.integer "pos"
    t.integer "draw"
    t.float "ovr_btn"
    t.float "btn"
    t.string "horse"
    t.integer "age"
    t.string "sex"
    t.integer "lbs"
    t.boolean "hg"
    t.string "time"
    t.float "secs"
    t.float "dec"
    t.string "jockey"
    t.string "trainer"
    t.integer "prize"
    t.integer "or"
    t.integer "rpr"
    t.string "sire"
    t.string "dam"
    t.string "damsire"
    t.string "owner"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_data", force: :cascade do |t|
    t.date "date"
    t.string "region"
    t.string "course"
    t.string "off"
    t.string "race_name"
    t.string "race_type"
    t.string "class_name"
    t.string "pattern"
    t.string "rating_band"
    t.string "age_band"
    t.string "sex_rest"
    t.string "dist"
    t.float "dist_f"
    t.integer "dist_m"
    t.string "going"
    t.integer "ran"
    t.integer "num"
    t.integer "pos"
    t.integer "draw"
    t.float "ovr_btn"
    t.float "btn"
    t.string "horse"
    t.integer "age"
    t.string "sex"
    t.integer "lbs"
    t.string "hg"
    t.string "time"
    t.float "secs"
    t.float "dec"
    t.string "jockey"
    t.string "trainer"
    t.float "prize"
    t.integer "or"
    t.integer "rpr"
    t.string "sire"
    t.string "dam"
    t.string "damsire"
    t.string "owner"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
