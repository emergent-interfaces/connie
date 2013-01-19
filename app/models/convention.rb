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
  has_many :auth_requirements

  has_one :planning_period, :class_name => 'Period', :conditions => {:special => 'planning'}

  searchable :auto_index => true, :auto_remove => true do
    text :name
  end

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

  after_create :add_auth_requirements
  def add_auth_requirements
    auth_requirements.create(:action => "read", :model => "Convention")
    auth_requirements.create(:action => "update", :model => "Convention")

    classes = ["Event", "Space", "Profile", "Job"]
    classes.each do |klass|
      auth_requirements.create(:action => "read", :model => klass)
      auth_requirements.create(:action => "update", :model => klass)
      auth_requirements.create(:action => "create", :model => klass)
      auth_requirements.create(:action => "destroy", :model => klass)
    end
  end
end
