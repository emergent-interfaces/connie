class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :department
      t.integer :convention_id

      t.timestamps
    end
  end
end
