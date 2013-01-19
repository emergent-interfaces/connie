require 'icalendar'

class Space < ActiveRecord::Base
  acts_as_taggable_on :tags   # needs to be called before acts_as_nested set https://github.com/mbleigh/acts-as-taggable-on/issues/229
  acts_as_nested_set
  include ReservableMixin

  validates_presence_of :name

  has_many :convention_linkables, :as => :linkable
  has_many :conventions, :through => :convention_linkables

  has_many :maps

  validates_presence_of :space_type
  validates_inclusion_of :space_type, :in => %w{building floor area room}

  has_one :own_address, :as => :addressable, :class_name => "Address"
  accepts_nested_attributes_for :own_address, :reject_if => proc {|attrs| attrs["text"].blank?}

  searchable :auto_index => true, :auto_remove => true do
    text :name, :venue_designated_name
  end

  def address
    inherit_address? ? inherited_address_space.own_address : own_address
  end

  def inherited_address_space(s=self)
    if s.inherit_address? and s.parent
      return inherited_address_space(s.parent)
    else
      puts "Found"
      return s
    end
  end

  def icalendar
    cal = Icalendar::Calendar.new

    reservations.each do |reservation|
      cal.event do
        dtstart reservation.event.time_span.start_time.iso8601
        dtend reservation.event.time_span.end_time.iso8601
        summary "#{reservation.event.name}"
        description "#{reservation.event.description}"
      end
    end

    cal
  end
end