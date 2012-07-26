class CreateScheduleReservables < ActiveRecord::Migration
  def change
    create_table :schedule_reservables do |t|
      t.string :reservable_type
      t.integer :reservable_id
      t.integer :schedule_id

      t.timestamps
    end
  end
end
