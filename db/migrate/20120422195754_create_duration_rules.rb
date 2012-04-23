class CreateDurationRules < ActiveRecord::Migration
  def change
    create_table :duration_rules do |t|
      t.integer :at_least
      t.integer :at_most

      t.timestamps
    end
  end
end
