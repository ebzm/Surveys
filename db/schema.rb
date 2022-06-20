# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_406_083_815) do
  create_table 'answers', force: :cascade do |t|
    t.float 'answer_val', null: false
    t.integer 'question_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'question_groups', force: :cascade do |t|
    t.string 'label'
    t.integer 'survey_id'
    t.index ['survey_id'], name: 'index_question_groups_on_survey_id'
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'questiontype'
    t.integer 'question_group_id'
    t.index ['question_group_id'], name: 'index_questions_on_question_group_id'
  end

  create_table 'surveys', force: :cascade do |t|
    t.string 'label'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.integer 'age'
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'account_type', default: 0, null: false
    t.index ['account_type'], name: 'index_users_on_account_type'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end
end
