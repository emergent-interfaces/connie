require 'icalendar'

class Space < ActiveRecord::Base
  acts_as_nested_set
  include ReservableMixin

  validates_presence_of :name

  has_many :convention_linkables, :as => :linkable
  has_many :conventions, :through => :convention_linkables

  has_many :maps

  validates_presence_of :space_type
  validates_inclusion_of :space_type, :in => %w{building floor area room}

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