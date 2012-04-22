class CreateIsRelatedRules < ActiveRecord::Migration
  def change
    create_table :is_related_rules do |t|
      t.integer :related_event_id
      t.string :relation
      t.timestamps
    end
  end
end
