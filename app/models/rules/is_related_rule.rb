class IsRelatedRule < ActiveRecord::Base
  include RuleMixin

  belongs_to :related_event, :class_name => "Event"
  validates_presence_of :related_event

  validates_inclusion_of :relation, :in => %w{before after}

  def message
    return :ruled_event_unscheduled unless event.scheduled?
    return :related_event_unscheduled unless related_event.scheduled?
    return :scheduled_in_violation if violated?
    :scheduled_ok
  end

  # todo How to check if related before the has_many is created?
  #def not_self_referencing
  #  unless new_record?
  #    errors.add(:related_event, "Cannot be related to self") if related_event_id == event.id
  #  end
  #end

  def satisfied?
    return false unless related_event.scheduled?
    return false unless event.scheduled?

    if relation == 'before'
      return true if event.time_span.before?(related_event.time_span)
    elsif relation == 'after'
      return true if event.time_span.after?(related_event.time_span)
    end

    false
  end
end
