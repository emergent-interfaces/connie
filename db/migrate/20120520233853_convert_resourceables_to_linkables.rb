class ConvertResourceablesToLinkables < ActiveRecord::Migration
  def change
    rename_table :convention_resourceables, :convention_linkables
    rename_column :convention_linkables, :resourceable_id, :linkable_id
    rename_column :convention_linkables, :resourceable_type, :linkable_type
  end
end
