class AddTypeToSpace < ActiveRecord::Migration
  def change
    add_column :maps, :type, :string
  end
end
