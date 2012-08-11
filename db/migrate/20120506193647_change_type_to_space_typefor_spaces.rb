class ChangeTypeToSpaceTypeforSpaces < ActiveRecord::Migration
  def change
    remove_column :maps, :type
    add_column :maps, :space_type, :string
  end
end
