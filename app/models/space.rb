class Space < ActiveRecord::Base
  acts_as_nested_set
  include ReservableMixin

  validates_presence_of :name

  has_many :convention_resourceables, :as => :resourceable
  has_many :conventions, :through => :convention_resourceables

  validates_presence_of :space_type
  validates_inclusion_of :space_type, :in => %w{building floor area room}
end