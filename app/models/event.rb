class Event < ActiveRecord::Base
  has_many :convention_resourceables, :as => :resourceable
  has_many :conventions, :through => :convention_resourceables
  has_one :time_span, :as => :time_spanable

  has_many :reservations, :dependent => :destroy

  has_many :rule_assignments, :dependent => :destroy
  has_many :rules, :through => :rule_assignments
  has_many :be_scheduled_rules, :through => :rule_assignments, :source_type => 'BeScheduledRule'

  def rules
    rule_assignments.collect {|rule_assignment| rule_assignment.rule}
  end

  def scheduled?
    return true if time_span
    false
  end
end
