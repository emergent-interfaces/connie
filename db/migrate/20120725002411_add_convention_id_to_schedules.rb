class AddConventionIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :convention_id, :integer
  end
end
