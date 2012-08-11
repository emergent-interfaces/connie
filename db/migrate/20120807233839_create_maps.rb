class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :space_id

      t.timestamps
    end
  end
end
