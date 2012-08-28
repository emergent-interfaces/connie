class RenameMeetOccupanyRuleToMeetsOccupancyRule < ActiveRecord::Migration
  def up
    rename_table :meet_occupany_rules, :meets_occupancy_rules
  end

  def down
    rename_table :meets_occupancy_rules, :meet_occupany_rules
  end
end
