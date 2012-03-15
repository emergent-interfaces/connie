class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :description
      t.references :tag_group
      t.timestamps
    end
    add_index :tags, :tag_group_id
  end
end
