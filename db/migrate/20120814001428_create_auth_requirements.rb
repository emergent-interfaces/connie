class CreateAuthRequirements < ActiveRecord::Migration
  def change
    create_table :auth_requirements do |t|
      t.integer :convention_id
      t.string :requirement

      t.timestamps
    end
  end
end
