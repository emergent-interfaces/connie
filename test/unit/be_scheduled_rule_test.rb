require 'test_helper'

class BeScheduledRuleTest < ActiveSupport::TestCase
  should have_one(:rule_assignment).dependent(:destroy)

  context "with a BeScheduledRule, RuleAssignment, and Event" do
    setup do
      @event = FactoryGirl.create(:event)
      @rule = BeScheduledRule.new
      @rule_assignment = RuleAssignment.new(:rule => @rule)
      @event.rule_assignments << @rule_assignment
    end

    should "be satisfied if Event has a TimeSpan" do
      @event.expects(:time_span).returns(TimeSpan.new)

      assert @rule.satisfied?
    end

    should "be violated if Event does not have a TimeSpan" do
      @event.expects(:time_span).returns(nil)

      assert @rule.violated?
    end

    should "not be satisfied if Event does not have a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(nil)
      
      refute @rule.satisfied?
    end

    should "not be violated if Event does not have a TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(TimeSpan.new)

      refute @rule.violated?
    end

    should "hint to schedule when no TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(nil)
      
      assert_equal I18n.t('rule.be_scheduled_rule.not_satisfied'), @rule.message
    end

    should "hint satisfied when Event has TimeSpan" do
      @rule_assignment.expects(:event).returns(@event)
      @event.expects(:time_span).returns(TimeSpan.new)
      
      assert_match I18n.t('rule.be_scheduled_rule.satisfied'), @rule.message
    end
  end
end
