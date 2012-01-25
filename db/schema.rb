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

ActiveRecord::Schema.define(:version => 20120125161206) do

  create_table "basketizations", :force => true do |t|
    t.integer  "task_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "basketizations", ["basket_id"], :name => "index_basketizations_on_basket_id"
  add_index "basketizations", ["task_id"], :name => "index_basketizations_on_task_id"

  create_table "baskets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habits", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habits", ["user_id"], :name => "index_habits_on_user_id"

  create_table "tasks", :force => true do |t|
    t.text     "name"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "duedate"
    t.integer  "user_id"
  end

  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "traces", :force => true do |t|
    t.integer  "habit_id"
    t.datetime "trace_date"
    t.boolean  "trace_complete"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "tracedate"
  end

  add_index "traces", ["habit_id"], :name => "index_traces_on_habit_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.boolean  "admin"
    t.string   "timezone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
