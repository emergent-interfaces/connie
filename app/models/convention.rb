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

  has_many :schedules
  has_many :periods
  has_many :auth_requirements

  searchable :auto_index => true, :auto_remove => true do
    text :name
  end

  after_create :add_auth_requirements
  def add_auth_requirements
    auth_requirements.create(:action => "read")
    auth_requirements.create(:action => "manage")
  end

  alias old_periods periods

  def periods(keyword=nil)
    return old_periods if keyword == nil

    old_periods.select{|period| period.name.underscore.include? keyword.to_s}
  end
end
