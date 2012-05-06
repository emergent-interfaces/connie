class AddTypeToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :type, :string
  end
end
