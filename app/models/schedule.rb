class Schedule < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  belongs_to :convention
  validates_presence_of :convention

  belongs_to :time_span
  validates_presence_of :time_span
  accepts_nested_attributes_for :time_span

  validates_presence_of :name

  has_many :schedule_reservables
  has_many :spaces, :through => :schedule_reservables, :source => :reservable, :source_type => 'Space'
  has_many :profiles, :through => :schedule_reservables, :source => :reservable, :source_type => 'Profile'

  def reservables
    spaces + profiles
  end

  def hours
    hour = time_span.start_time.change(:sec => 0, :min => 0)

    hours = []

    while hour < time_span.end_time
      hours << hour
      hour += 1.hour
    end

    hours << hour

    hours
  end

  def reservations(reservable=nil)
    if reservable
      reservations = Reservation.find_all_by_reservable_id(reservable.id)
    else
      reservations = Reservation.all
    end

    reservations = reservations.keep_if {|r| r.scheduled? }
    reservations = reservations.keep_if {|r| r.time_span.end_time > time_span.start_time && r.time_span.start_time < time_span.end_time}
    reservations
  end
  memoize :reservations

  def critical_times
    critical_times = reservations.collect{|r| r.time_span.start_time} + reservations.collect{|r| r.time_span.end_time}
    critical_times.uniq!.sort!
  end

  def happenings_at(time, type)
    collection = reservations.find_all{|r| r.time_span.start_time == time} if type == :starts
    collection = reservations.find_all{|r| r.time_span.end_time == time} if type == :ends
    collection
  end
end