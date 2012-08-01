class Convention < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :convention_linkables
  has_many :linkables, :through => :convention_linkables
  has_many :events, :through => :convention_linkables, :source => :linkable,
                    :source_type => "Event"
  has_many :spaces, :through => :convention_linkables, :source => :linkable,
                    :source_type => "Space"
  has_many :profiles, :through => :convention_linkables, :source => :linkable,
                    :source_type => "Profile"
  has_many :jobs, :through => :convention_linkables, :source => :linkable,
           :source_type => "Job"

  after_create :create_tag
  before_save :rename_tag

  has_many :schedules
  has_many :periods

  def create_tag
    tag = Tag.new(:name => self.name, :tag_group => TagGroup.find_by_name('Conventions'))
    tag.save
  end

  def rename_tag
    unless self.new_record?
      tag = Tag.find_by_group_and_tag_name('Conventions', self.name_was)
      tag.name = self.name
      tag.save
    end
  end
end
