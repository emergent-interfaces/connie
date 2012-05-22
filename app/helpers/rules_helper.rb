module RulesHelper
  def rule_status_icon(rule)
    return image_tag "icons/accept.png" if rule.satisfied?
    image_tag "icons/error.png"
  end

  def rule_message(rule)
    send("message_for_#{rule.class.name.underscore}", rule).html_safe
  end

  def message_for_be_scheduled_rule(rule)
    return "This event is scheduled" if :event_is_scheduled
    "This event must be scheduled"
  end

  def message_for_is_related_rule(rule)
    event = rule.rule_assignment.event

    case rule.message
      when :ruled_event_unscheduled
        "This event must be scheduled"
      when :related_event_unscheduled
        "#{rule.related_event.name} must be scheduled"
      when :scheduled_in_violation
        "#{event.name} must be scheduled #{rule.relation} #{link_to rule.related_event.name, rule.related_event}"
      when :scheduled_ok
        "#{event.name} is scheduled #{rule.relation} #{link_to rule.related_event.name, rule.related_event}"
    end
  end

  def message_for_duration_rule(rule)
    event = rule.rule_assignment.event
    event_duration_str = ChronicDuration.output(event.time_span.duration.to_i)
    msg = ""

    case rule.message
      when :duration_ok
        msg << "The event has a duration of #{event_duration_str} which satisfies"
        msg << " a minimum duration of #{ChronicDuration.output(rule.min_duration)}" if rule.min_duration
        msg << " and" if (rule.min_duration && rule.max_duration)
        msg << " a maximum duration of #{ChronicDuration.output(rule.max_duration)}" if rule.max_duration
      when :duration_violated
        msg << "The event has a duration of #{event_duration_str} which violates"
        msg << " a minimum duration of #{ChronicDuration.output(rule.min_duration)}" if rule.min_duration
        msg << " and" if (rule.min_duration && rule.max_duration)
        msg << " a maximum duration of #{ChronicDuration.output(rule.max_duration)}" if rule.max_duration
    end

    msg
  end

  def rule_status_icon(rule)
    if rule.satisfied?
      rule_satisfied_icon
    else
      rule_violated_icon
    end
  end

  def rule_violated_icon
    image_tag "icons/error.png"#, :style => "position: relative; top: 1px; padding: 0px 3px;"
  end

  def rule_satisfied_icon
    image_tag "icons/accept.png"#, :style => "position: relative; top: 1px; padding: 0px 3px;"
  end
end
