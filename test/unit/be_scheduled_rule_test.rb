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
      @time_span = FactoryGirl.create(:time_span)
      @event.time_span = @time_span
      @event.save

      assert @rule.satisfied?
    end

    should "be violated if Event does not have a TimeSpan" do
      assert @rule.violated?
    end

    should "not be satisfied if Event does not have a TimeSpan" do
      refute @rule.satisfied?
    end

    should "not be violated if Event does not have a TimeSpan" do
      @time_span = FactoryGirl.create(:time_span)
      @event.time_span = @time_span
      @event.save

      refute @rule.violated?
    end

    should "hint to schedule when no TimeSpan" do
      assert_equal :event_not_scheduled, @rule.message
    end

    should "hint satisfied when Event has TimeSpan" do
      @time_span = FactoryGirl.create(:time_span)
      @event.time_span = @time_span
      @event.save
      
      assert_equal :event_is_scheduled, @rule.message
    end
  end
end
