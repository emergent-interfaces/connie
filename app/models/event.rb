class Event < ActiveRecord::Base
  has_many :convention_resourceables, :as => :resourceable
  has_many :conventions, :through => :convention_resourceables
  has_one :time_span, :as => :time_spanable

  has_many :rule_assignments, :dependent => :destroy
  has_many :be_scheduled_rules, :through => :rule_assignments, :source_type => 'BeScheduledRule'
end
