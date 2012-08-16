class AddAbilityToAuthRequirement < ActiveRecord::Migration
  def change
    add_column :auth_requirements, :ability, :string
  end
end
