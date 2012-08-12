class DurationRule < ActiveRecord::Base
  include RuleMixin

  validate :min_or_max_set
  validate :min_less_than_max

  def satisfied?
    if min_duration
      return false if event.time_span.duration < min_duration
    end

    if max_duration
      return false if event.time_span.duration > max_duration
    end

    true
  end

  def min_or_max_set
    unless self.min_duration || self.max_duration
      errors.add(:base, "Minimum or maximum duration must be set")
    end
  end

  def min_less_than_max
    if self.min_duration && self.max_duration
      errors.add(:min_duration, "must be less than 'at most'") if self.min_duration > self.max_duration
    end
  end

  def message
    return :duration_ok if satisfied?

    :duration_violated
  end
end
