class CreateConventionEvents < ActiveRecord::Migration
  def change
    create_table :convention_events do |t|
      t.references :convention
      t.references :event

      t.timestamps
    end
  end
end
