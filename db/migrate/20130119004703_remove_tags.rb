class RemoveTags < ActiveRecord::Migration
  def change
    drop_table :tag_groups
    drop_table :taggings
  end
end
