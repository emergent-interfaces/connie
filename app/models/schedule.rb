class Schedule < ActiveRecord::Base
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
end