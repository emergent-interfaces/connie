require 'range'

class TimeSpan < ActiveRecord::Base
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :confidence
  validate :end_time_follows_start_time

  CONFIDENCES = {"tentative" => 0, "likely" => 1, "firm" => 2}
  after_initialize :init_confidence_to_max

  belongs_to :time_spanable, :polymorphic => true

  def span
    return start_time...end_time
  end

  def end_time_follows_start_time
    errors.add(:end_time, "must follow start time") unless (end_time.to_i > start_time.to_i)
  end

  def is_during?(time_spans)
    time_spans.each do |ts|
      return true if ts.span.overlap?(self.span)
    end

    false
  end

  def before?(time_span)
    return true if end_time < time_span.start_time
    false
  end

  def after?(time_span)
    return true if start_time > time_span.end_time
    false
  end

  def init_confidence_to_max
    self.confidence = CONFIDENCES.values.max
  end

  def duration(resolution = :seconds)
    case resolution
      when :seconds
        duration_in_seconds
      when :minutes
        duration_in_seconds/60
      when :hours
        duration_in_seconds/3600
    end
  end

  def duration_in_seconds
    end_time - start_time
  end
end