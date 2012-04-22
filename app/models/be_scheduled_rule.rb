class BeScheduledRule < ActiveRecord::Base
  include RuleMixin
      
  def satisfied?
    return true if event.time_span
    false
  end

  def message
    if satisfied?
      :event_is_scheduled
    else
      :event_not_scheduled
    end
  end
end
