module RuleMixin

  def self.included(base)
    base.has_one :rule_assignment, :as => :rule, :dependent => :destroy
    base.has_one :event, :through => :rule_assignment
  end

  def satisfied?
    false
  end

  def violated?
    !satisfied?
  end

  def activity
    rule_assignment.activity
  end

  def message
    ""
  end

end