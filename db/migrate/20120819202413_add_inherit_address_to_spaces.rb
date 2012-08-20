class AddInheritAddressToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :inherit_address, :boolean
  end
end
