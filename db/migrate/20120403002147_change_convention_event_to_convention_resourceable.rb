class ChangeConventionEventToConventionResourceable < ActiveRecord::Migration
  def up
    rename_table :convention_events, :convention_resourceables
    rename_column :convention_resourceables, :event_id, :resourceable_id
    add_column :convention_resourceables, :resourceable_type, :string
  end

  def down
    rename_table :convention_resourceables, :convention_events
    rename_column :convention_events, :resourceable_id, :event_id
    remove_column :convention_events, :resourceable_type
  end
end
