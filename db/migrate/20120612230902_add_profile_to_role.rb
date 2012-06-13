class AddProfileToRole < ActiveRecord::Migration
  def change
    add_column :roles, :profile_id, :integer

  end
end
