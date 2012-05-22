class AddOccupancyInfoForSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :occupancy_seated, :integer
    add_column :spaces, :occupancy_standing, :integer
  end
end
