class BeScheduledRule < ActiveRecord::Base
  include RuleMixin
      
  def satisfied?
    return true if self.rule_assignment.event.time_span
    false
  end

  def current_hint
    if satisfied?
      I18n.t 'rule.be_scheduled_rule.satisfied'
    else
      I18n.t 'rule.be_scheduled_rule.not_satisfied'
    end
  end
end
