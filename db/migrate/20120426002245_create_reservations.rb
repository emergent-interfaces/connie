class CreateReservations < ActiveRecord::Migration
  def up
    create_table :reservations do |t|
      t.integer :event_id
      t.string :reservable_type
      t.integer :reservable_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def down
    drop_table :reservations
  end
end
