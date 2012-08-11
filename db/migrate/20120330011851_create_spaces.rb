class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.string :venue_designated_name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
  end
end
