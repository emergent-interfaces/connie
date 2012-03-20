class Tag < ActiveRecord::Base
  # Really weird: if you change or get rid of the following 2 belongs_to
  # statements, you get errors during testing
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true

  belongs_to :tag_group
  has_many :taggings

  def self.find_by_group_and_tag_name(group_name, tag_name)
    Tag.where(:tag_group_id => TagGroup.find_by_name(group_name), :name=> tag_name).first
  end

end
