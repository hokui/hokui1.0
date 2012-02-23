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

ActiveRecord::Schema.define(:version => 20120223040007) do

  create_table "exams", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "year",         :null => false
    t.boolean  "type",         :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams", ["file"], :name => "index_exams_on_file", :unique => true

  create_table "quizzes", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "number",       :null => false
    t.boolean  "type",         :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizzes", ["file"], :name => "index_quizzes_on_file", :unique => true

  create_table "subjects", :force => true do |t|
    t.integer  "term_id",      :null => false
    t.string   "page_title",   :null => false
    t.string   "screen_title", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["page_title"], :name => "index_subjects_on_page_title", :unique => true
  add_index "subjects", ["screen_title"], :name => "index_subjects_on_screen_title", :unique => true

  create_table "summaries", :force => true do |t|
    t.integer  "subject_id",   :null => false
    t.integer  "number",       :null => false
    t.binary   "file",         :null => false
    t.string   "content_type", :null => false
    t.string   "file_name",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "summaries", ["file"], :name => "index_summaries_on_file", :unique => true

  create_table "terms", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
