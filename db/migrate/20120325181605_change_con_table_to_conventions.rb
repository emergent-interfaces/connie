class ChangeConTableToConventions < ActiveRecord::Migration
  def up
    rename_table :cons, :conventions
  end

  def down
    rename_table :conventions, :cons
  end
end
