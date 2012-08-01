class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name
      t.integer :convention_id
      t.string :special

      t.timestamps
    end
  end
end
