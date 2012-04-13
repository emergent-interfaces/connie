class CreateBeScheduledRulesTable < ActiveRecord::Migration
  def up
    create_table "be_scheduled_rules", :force => true do |t|
        t.datetime "created_at"
        t.datetime "updated_at"
      end
  end

  def down
    drop_table :be_scheduled_rules
  end
end
