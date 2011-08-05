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

ActiveRecord::Schema.define(:version => 20110805181214) do

  create_table "game_players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_players", ["game_id"], :name => "game_id_idx"
  add_index "game_players", ["player_id"], :name => "player_id_idx"

  create_table "game_turns", :force => true do |t|
    t.integer  "round_number"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "start_unit_data"
    t.text     "current_unit_data"
    t.text     "end_unit_data"
    t.string   "player"
    t.text     "current_tile_owner_data"
    t.text     "resource_data"
  end

  add_index "game_turns", ["game_id", "created_at"], :name => "game_order_id_idx"

  create_table "games", :force => true do |t|
    t.integer  "map_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "game_winner"
  end

  create_table "maps", :force => true do |t|
    t.string   "name"
    t.text     "tile_data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "height"
    t.integer  "width"
    t.text     "unit_data"
    t.integer  "number_of_players", :default => 2, :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.boolean  "admin"
  end

  add_index "players", ["provider", "uid"], :name => "provider_uid_idx"

  create_table "terrain_modifiers", :force => true do |t|
    t.integer  "unit_type_id"
    t.integer  "tile_type_id"
    t.integer  "defense_bonus"
    t.integer  "movement_cost"
    t.string   "tile_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terrain_modifiers", ["unit_type_id"], :name => "unit_type_idx"

  create_table "tile_types", :force => true do |t|
    t.string   "name"
    t.string   "img"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "img_x",      :default => 0, :null => false
    t.integer  "img_y",      :default => 0, :null => false
    t.boolean  "ownable"
  end

  create_table "turn_actions", :force => true do |t|
    t.integer  "game_turn_id"
    t.string   "action"
    t.integer  "unit_x"
    t.integer  "unit_y"
    t.integer  "target_x"
    t.integer  "target_y"
    t.string   "value"
    t.string   "param2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_types", :force => true do |t|
    t.string   "name"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "attack_range",  :default => 1, :null => false
    t.integer  "move_range",    :default => 2, :null => false
    t.integer  "img_x",         :default => 0, :null => false
    t.integer  "img_y",         :default => 0, :null => false
    t.integer  "attack_power"
    t.integer  "defense_power"
  end

end
