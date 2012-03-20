class Tag < ActiveRecord::Base
  belongs_to :tag_group
  has_many :taggings

  def self.find_by_group_and_tag_name(group_name, tag_name)
    Tag.where(:tag_group_id => TagGroup.find_by_name(group_name), :name=> tag_name).first
  end

end
