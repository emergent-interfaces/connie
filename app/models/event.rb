class Event < ActiveRecord::Base
  has_many :convention_events
  has_many :conventions, :through => :convention_events
end
