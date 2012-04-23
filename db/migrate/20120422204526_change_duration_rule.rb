class ChangeDurationRule < ActiveRecord::Migration
  def up
    rename_column :duration_rules, :at_least, :min_duration
    rename_column :duration_rules, :at_most, :max_duration
  end

  def down
    rename_column :duration_rules, :max_duration, :at_most
    rename_column :duration_rules, :min_duration, :at_least
  end
end
