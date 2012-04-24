class Space < ActiveRecord::Base
  acts_as_nested_set

  validates_presence_of :name
  #validates_presence_of :venue_designated_name

  has_many :convention_resourceables, :as => :resourceable
  has_many :conventions, :through => :convention_resourceables
end
