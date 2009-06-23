# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081115181851) do

  create_table "documents", :force => true do |t|
    t.string   "urn"
    t.string   "title"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subdocs", :force => true do |t|
    t.string   "label"
    t.integer  "document_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_urn"
    t.string   "field1"
    t.string   "field2"
    t.string   "value1"
    t.string   "value2"
  end

  add_index "subdocs", ["document_urn"], :name => "index_subdocs_on_document_urn"
  add_index "subdocs", ["label"], :name => "index_subdocs_on_label"

  create_table "treebanks", :force => true do |t|
    t.integer  "word_id"
    t.string   "word_form"
    t.integer  "head_id"
    t.string   "relation"
    t.string   "postag"
    t.string   "lemma"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sentence"
    t.string   "document_urn"
    t.string   "subdoc"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "address"
    t.string   "name"
  end

  create_table "words", :force => true do |t|
    t.string   "form"
    t.integer  "sentence"
    t.string   "document_urn"
    t.string   "document_span"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdoc"
    t.integer  "number"
    t.string   "span"
    t.integer  "perseusId"
    t.integer  "lang_id"
  end

  add_index "words", ["document_urn"], :name => "index_words_on_document_urn"
  add_index "words", ["subdoc"], :name => "index_words_on_subdoc"

end
