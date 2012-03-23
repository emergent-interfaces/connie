class Con < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :create_tag
  before_save :rename_tag

  def create_tag
    tag = Tag.new(:name => self.name, :tag_group => TagGroup.find_by_name('Cons'))
    tag.save
  end

  def rename_tag
    unless self.new_record?
      tag = Tag.find_by_group_and_tag_name('Cons', self.name_was)
      tag.name = self.name
      tag.save
    end
  end
end