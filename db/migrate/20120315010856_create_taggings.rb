class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic => true

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :taggable_id
  end
end
