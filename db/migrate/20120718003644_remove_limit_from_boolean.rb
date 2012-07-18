class RemoveLimitFromBoolean < ActiveRecord::Migration
  def change
    change_column :reservations, :inherit_time_span, :boolean, :limit => nil
  end
end
