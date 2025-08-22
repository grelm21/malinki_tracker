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

ActiveRecord::Schema[7.1].define(version: 2025_08_17_153310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.integer "class_format"
    t.bigint "wage_cents"
    t.text "comment"
    t.integer "length"
    t.text "schedule", default: [], array: true
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_classrooms_on_teacher_id"
  end

  create_table "classrooms_students", force: :cascade do |t|
    t.integer "payment_type"
    t.bigint "classroom_id"
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_classrooms_students_on_classroom_id"
    t.index ["student_id"], name: "index_classrooms_students_on_student_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "amount_cents"
    t.datetime "issued_at"
    t.bigint "classrooms_student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classrooms_student_id"], name: "index_deposits_on_classrooms_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "contact_details"
    t.string "saved_password"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "students_teachers", id: false, force: :cascade do |t|
    t.bigint "teacher_id"
    t.bigint "student_id"
    t.index ["student_id"], name: "index_students_teachers_on_student_id"
    t.index ["teacher_id"], name: "index_students_teachers_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "login", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.bigint "amount_cents"
    t.datetime "issued_at"
    t.bigint "classrooms_student_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classrooms_student_id"], name: "index_withdrawals_on_classrooms_student_id"
    t.index ["teacher_id"], name: "index_withdrawals_on_teacher_id"
  end

  add_foreign_key "classrooms", "teachers"
  add_foreign_key "deposits", "classrooms_students"
  add_foreign_key "students", "users"
  add_foreign_key "students_teachers", "students"
  add_foreign_key "students_teachers", "teachers"
  add_foreign_key "withdrawals", "classrooms_students"
  add_foreign_key "withdrawals", "teachers"
end
