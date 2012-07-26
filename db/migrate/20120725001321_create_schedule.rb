class CreateSchedule < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.integer :time_span_id
      t.timestamps
    end
  end
end
