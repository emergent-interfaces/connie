class AddModelToAuthRequirements < ActiveRecord::Migration
  def change
    rename_column :auth_requirements, :ability, :action
    add_column :auth_requirements, :model, :string
  end
end
