class Event < ActiveRecord::Base
  has_many :convention_linkables, :as => :linkable
  has_many :conventions, :through => :convention_linkables
  has_one :time_span, :as => :time_spanable

  has_many :reservations, :as => :reservee, :dependent => :destroy

  has_many :rule_assignments, :dependent => :destroy
  has_many :rules, :through => :rule_assignments
  has_many :be_scheduled_rules, :through => :rule_assignments, :source_type => 'BeScheduledRule'

  acts_as_commentable

  def rules
    rule_assignments.collect {|rule_assignment| rule_assignment.rule}
  end

  def scheduled?
    return true if time_span
    false
  end

  searchable :auto_index => true, :auto_remove => true do
    text :name, :description
  end
end
