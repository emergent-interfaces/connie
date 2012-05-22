module EventsHelper
  def violated_rules_count(event)
    count = 0
    event.rule_assignments.each do |ra|
      count+=1 if ra.rule.violated?
    end
    count
  end

  def satisfied_rules_count(event)
    count = 0
    event.rule_assignments.each do |ra|
      count+=1 if ra.rule.satisfied?
    end
    count
  end

  def rules_summary(event)
    summary = ""

    if violated_rules_count(event) > 0
      summary << "<span class=violated_rules_indicator>"
      summary << rule_violated_icon
      summary << violated_rules_count(event).to_s
      summary << "</span>"
    end

    if satisfied_rules_count(event) > 0
      summary << "<span class=satisfied_rules_indicator>"
      summary << rule_satisfied_icon
      summary << satisfied_rules_count(event).to_s
      summary << "</span>"
    end

    summary.html_safe
  end
end
