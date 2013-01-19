class CreateReservesTaggeds < ActiveRecord::Migration
  def change
    create_table :reserves_tagged_rules do |t|
      t.string :tagged_type
      t.string :tag
      t.string :context
      t.timestamps
    end
  end
end
