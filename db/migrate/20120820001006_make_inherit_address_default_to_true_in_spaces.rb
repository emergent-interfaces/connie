class MakeInheritAddressDefaultToTrueInSpaces < ActiveRecord::Migration
  def change
    change_column :spaces, :inherit_address, :boolean, :default => true
  end
end
