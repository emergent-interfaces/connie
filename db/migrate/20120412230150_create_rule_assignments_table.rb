class CreateRuleAssignmentsTable < ActiveRecord::Migration
  def up
    create_table "rule_assignments", :force => true do |t|
        t.integer  "rule_id"
        t.string   "rule_type"
        t.integer  "event_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.boolean  "removable"
      end
  end

  def down
    drop_table :rule_assignments
  end
end
