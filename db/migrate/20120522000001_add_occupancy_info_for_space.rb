class AddOccupancyInfoForSpace < ActiveRecord::Migration
  def change
    add_column :maps, :occupancy_seated, :integer
    add_column :maps, :occupancy_standing, :integer
  end
end
