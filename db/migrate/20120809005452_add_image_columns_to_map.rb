class AddImageColumnsToMap < ActiveRecord::Migration
  def self.up
    add_attachment :maps, :image
  end

  def self.down
    remove_attachment :maps, :image
  end
end
