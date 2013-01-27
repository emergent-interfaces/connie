require 'range'

class TimeSpan < ActiveRecord::Base
  attr_accessible :natural_start_time, :natural_end_time, :confidence

  validates_presence_of :natural_start_time
  validates_presence_of :natural_end_time
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :confidence
  validate :end_time_follows_start_time

  CONFIDENCES = {"tentative" => 0, "likely" => 1, "firm" => 2}

  belongs_to :time_spanable, :polymorphic => true

  def natural_start_time
    @natural_start_time = I18n.l(self[:start_time]) if self[:start_time] && @natural_start_time == nil
    @natural_start_time
  end

  def natural_end_time
    @natural_end_time = I18n.l(self[:end_time]) if self[:end_time] && @natural_end_time == nil
    @natural_end_time
  end

  def natural_start_time=(time_str)
    @natural_start_time = time_str
  end

  def natural_end_time=(time_str)
    @natural_end_time = time_str
  end

  def chronic_parse(time_str)
    return Chronic.parse(time_str)
  end

  before_validation do
    puts natural_start_time
    self.start_time = chronic_parse(natural_start_time)
    self.end_time = chronic_parse(natural_end_time)
  end

  def span
    return start_time...end_time
  end

  def end_time_follows_start_time
    errors.add(:end_time, "must follow start time") unless (end_time.to_i > start_time.to_i)
    errors.add(:natural_end_time, "must follow start time #{self.start_time}") unless (end_time.to_i > start_time.to_i)
  end

  def is_during?(time_spans)
    time_spans.each do |ts|
      return true if ts.span.overlap?(self.span)
    end

    false
  end

  def before?(time_span)
    return true if end_time <= time_span.start_time
    false
  end

  def after?(time_span)
    return true if start_time >= time_span.end_time
    false
  end

  def duration(resolution = :seconds)
    case resolution
      when :seconds
        duration_in_seconds
      when :minutes
        duration_in_seconds/60.0
      when :hours
        duration_in_seconds/3600.0
    end
  end

  def duration_in_seconds
    Float(end_time - start_time)
  end
end