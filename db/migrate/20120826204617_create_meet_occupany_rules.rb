class CreateMeetOccupanyRules < ActiveRecord::Migration
  def change
    create_table :meet_occupany_rules do |t|
      t.string :arrangement
      t.integer :capacity

      t.timestamps
    end
  end
end
