class Event < ActiveRecord::Base
  has_many :convention_resourceables, :as => :resourceable
  has_many :conventions, :through => :convention_resourceables
  has_one :time_span, :as => :time_spanable
end
