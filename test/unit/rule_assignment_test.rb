require 'test_helper'

class RuleAssignmentTest < ActiveSupport::TestCase
  should belong_to(:rule).dependent(:destroy)
  should belong_to :event

  should validate_presence_of :rule
  should validate_presence_of :event
  
  should allow_value(true).for(:removable)
  should allow_value(false).for(:removable)
  should_not allow_value(nil).for(:removable)

  context "with a Rule and RuleAssignment" do
    setup do
      @rule_assignment = RuleAssignment.new
      @rule = BeScheduledRule.new

      @rule_assignment.rule = @rule
    end

    should "destroy Rule if RuleAssignment destroyed" do
      @rule.expects(:destroy)

      @rule_assignment.destroy
    end

    should "when removable is nil should default to true" do
      assert @rule_assignment.removable
    end

    should "when removable is false should not be overwritten" do
      @rule_assignment.removable = false
      @rule_assignment.valid?
      refute @rule_assignment.removable
    end
  end
end