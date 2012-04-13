require 'test_helper'

class BeScheduledRuleTest < ActiveSupport::TestCase
  should have_one(:rule_assignment).dependent(:destroy)

  context "with a BeScheduledRule, RuleAssignment, and Activity" do
    setup do
      @rule = BeScheduledRule.new
      @rule_assignment = RuleAssignment.new
      @event = Event.new

      @rule.rule_assignment = @rule_assignment
    end

    should "be satisfied if Activity has a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(TimeSpan.new)

      assert @rule.satisfied?
    end

    should "be violated if Activity does not have a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(nil)

      assert @rule.violated?
    end

    should "not be satisfied if Activity does not have a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(nil)
      
      refute @rule.satisfied?
    end

    should "not be violated if Activity does not have a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(TimeSpan.new)

      refute @rule.violated?
    end

    should "hint to schedule when no TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(nil)
      
      assert_equal I18n.t('rule.be_scheduled_rule.not_satisfied'), @rule.current_hint
    end

    should "hint satisfied when Activity has TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(TimeSpan.new)
      
      assert_match I18n.t('rule.be_during_event_rule.satisfied'), @rule.current_hint
    end
  end
end
