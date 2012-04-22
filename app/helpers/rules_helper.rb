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
        "#{event.name} is scheduled #{rule.relation} #{rule.related_event.name}"
    end
  end
end
