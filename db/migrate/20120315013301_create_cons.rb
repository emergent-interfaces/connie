class CreateCons < ActiveRecord::Migration
  def change
    create_table :cons do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
