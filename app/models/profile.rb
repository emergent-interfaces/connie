class Profile < ActiveRecord::Base
  validates_presence_of :name

  has_many :convention_linkables, :as => :linkable
  has_many :conventions, :through => :convention_linkables
  has_many :phones, :as => :phoneable
  has_many :roles

  has_one :user

  has_many :assignees
  has_many :jobs, :through => :assignees

  searchable :auto_index => true, :auto_remove => true do
    text :name
  end

  def departments
    roles.collect {|role| role.department}.uniq
  end
end
