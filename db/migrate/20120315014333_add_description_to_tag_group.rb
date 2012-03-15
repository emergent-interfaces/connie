class AddDescriptionToTagGroup < ActiveRecord::Migration
  def change
      change_table :tag_groups do |t|
        t.string :description
      end
  end
end
