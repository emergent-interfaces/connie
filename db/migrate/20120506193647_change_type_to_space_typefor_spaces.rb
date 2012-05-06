class ChangeTypeToSpaceTypeforSpaces < ActiveRecord::Migration
  def change
    remove_column :spaces, :type
    add_column :spaces, :space_type, :string
  end
end
