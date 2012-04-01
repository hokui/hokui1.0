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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120401123658) do

  create_table "bbs_bodies", :force => true do |t|
    t.integer  "bbs_topic_id",  :null => false
    t.integer  "user_id",       :null => false
    t.text     "text",          :null => false
    t.boolean  "deleted",       :null => false
    t.integer  "deleted_by"
    t.boolean  "topic_deleted", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bbs_groups", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_a_term",  :null => false
  end

  create_table "bbs_topics", :force => true do |t|
    t.integer  "bbs_group_id", :null => false
    t.integer  "user_id",      :null => false
    t.string   "title",        :null => false
    t.boolean  "deleted",      :null => false
    t.integer  "deleted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "year",         :null => false
    t.integer  "number",       :null => false
    t.string   "q_a",          :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.integer  "uploaded_by",  :null => false
    t.boolean  "deleted",      :null => false
    t.integer  "deleted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "number",       :null => false
    t.string   "q_a",          :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.integer  "uploaded_by",  :null => false
    t.boolean  "deleted",      :null => false
    t.integer  "deleted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.integer  "term_id",      :null => false
    t.string   "title_ja",     :null => false
    t.string   "title_en",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bbs_topic_id", :null => false
    t.string   "teacher",      :null => false
  end

  create_table "summaries", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "number",       :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.integer  "uploaded_by",  :null => false
    t.boolean  "deleted",      :null => false
    t.integer  "deleted_by",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "title",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bbs_group_id", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "handle_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthday"
    t.string   "mail"
    t.string   "authority"
    t.integer  "invited_by"
    t.string   "password_digest"
    t.integer  "new_column"
  end

end
