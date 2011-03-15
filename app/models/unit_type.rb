class UnitType < ActiveRecord::Base
  validates :name, :presence=>true
  validates :img, :presence=>true
  validates :img_x, :presence=>true, :numericality => {:greater_than_or_equal_to => 0}
  validates :img_y, :presence=>true, :numericality => {:greater_than_or_equal_to => 0}
  validates :attack_range, :presence=>true, :numericality => {:greater_than_or_equal_to => 1}
  validates :move_range, :presence=>true, :numericality => {:greater_than_or_equal_to => 0}
  acts_as_list
end




# == Schema Information
#
# Table name: unit_types
#
#  id                          :integer         not null, primary key
#  name                        :string(255)
#  img                         :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  position                    :integer
#  attack_range                :integer         default(1), not null
#  move_cost_grass             :integer         default(1), not null
#  move_cost_dirt              :integer         default(1), not null
#  move_cost_city              :integer         default(1), not null
#  move_cost_castle            :integer         default(1), not null
#  move_cost_water             :integer         default(1), not null
#  move_cost_bridge_left       :integer         default(1), not null
#  move_cost_bridge_right      :integer         default(1), not null
#  move_cost_bridge_center     :integer         default(1), not null
#  move_cost_path              :integer         default(1), not null
#  move_cost_swamp             :integer         default(1), not null
#  move_cost_desert            :integer         default(1), not null
#  move_cost_oasis             :integer         default(1), not null
#  move_cost_forest            :integer         default(1), not null
#  move_cost_hills             :integer         default(1), not null
#  move_cost_mountains         :integer         default(1), not null
#  defense_bonus_grass         :integer         default(0), not null
#  defense_bonus_dirt          :integer         default(0), not null
#  defense_bonus_city          :integer         default(0), not null
#  defense_bonus_castle        :integer         default(0), not null
#  defense_bonus_water         :integer         default(0), not null
#  defense_bonus_bridge_left   :integer         default(0), not null
#  defense_bonus_bridge_right  :integer         default(0), not null
#  defense_bonus_bridge_center :integer         default(0), not null
#  defense_bonus_path          :integer         default(0), not null
#  defense_bonus_swamp         :integer         default(0), not null
#  defense_bonus_desert        :integer         default(0), not null
#  defense_bonus_oasis         :integer         default(0), not null
#  defense_bonus_forest        :integer         default(0), not null
#  defense_bonus_hills         :integer         default(0), not null
#  defense_bonus_mountains     :integer         default(0), not null
#  move_range                  :integer         default(1), not null
#  img_x                       :integer         default(0), not null
#  img_y                       :integer         default(0), not null
#

