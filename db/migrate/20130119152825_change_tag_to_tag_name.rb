class ChangeTagToTagName < ActiveRecord::Migration
  def change
    rename_column :reserves_tagged_rules, :tag, :tag_name
  end
end
