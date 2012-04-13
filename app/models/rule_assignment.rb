class RuleAssignment < ActiveRecord::Base
  belongs_to :rule, :polymorphic => true, :dependent => :destroy
  belongs_to :event

  validates_presence_of :rule
  validates_presence_of :event
  validates_inclusion_of :removable, :in => [true, false]

  after_initialize :default_removable_to_true

  def default_removable_to_true
    self.removable = true if self.removable == nil
  end
end
