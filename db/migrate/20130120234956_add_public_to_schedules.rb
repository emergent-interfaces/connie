class AddPublicToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :public, :boolean, :default => false
  end
end
