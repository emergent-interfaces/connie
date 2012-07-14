class ChangeInheritTimeSpanToBoolean < ActiveRecord::Migration
  def change
    change_column :reservations, :inherit_time_span, :boolean
  end
end
