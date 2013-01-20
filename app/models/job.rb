class Job < ActiveRecord::Base
  validates_presence_of :name

  has_many :convention_linkables, :as => :linkable
  has_many :conventions, :through => :convention_linkables

  has_many :assignees
  has_many :profiles, :through => :assignees

  acts_as_commentable

  searchable :auto_index => true, :auto_remove => true do
    text :name, :description
  end
end
