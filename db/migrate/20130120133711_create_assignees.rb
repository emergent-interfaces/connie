class CreateAssignees < ActiveRecord::Migration
  def change
    create_table :assignees do |t|
      t.integer :job_id
      t.integer :profile_id

      t.timestamps
    end
  end
end
