class Space < ActiveRecord::Base
  acts_as_nested_set

  validates_presence_of :name
  validates_presence_of :venue_designated_name
end
