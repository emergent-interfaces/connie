class CreateTimeSpans < ActiveRecord::Migration
  def change
    create_table :time_spans do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :confidence
      t.string :time_spanable_type
      t.integer :time_spanable_id

      t.timestamps
    end
  end
end
