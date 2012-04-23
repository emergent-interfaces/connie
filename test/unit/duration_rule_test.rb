require 'test_helper'

class DurationRuleTest < ActiveSupport::TestCase
  should have_one(:event).through(:rule_assignment)

  should "not save if no minimum or maximum duration set" do
    refute DurationRule.new.save
  end

  should "save if minimum duration set" do
    assert DurationRule.new(:min_duration => 10).save
  end

  should "save if maximum duration set" do
    assert DurationRule.new(:max_duration => 10).save
  end

  should "save if minimum and maximum duration set" do
    assert DurationRule.new(:min_duration => 10, :max_duration => 10).save
  end

  should "not save if maximum duration is less than minimum duration" do
    refute DurationRule.new(:min_duration => 20, :max_duration => 10).save
  end

  context "with a DurationRule assigned to an Event" do
    setup do
      @event = FactoryGirl.create(:event)
      @rule = DurationRule.create(:min_duration => 10)
      @rule_assignment = RuleAssignment.create(:event => @event, :rule => @rule)
      @event.create_time_span(:start_time => Time.parse("Jan 1st 1:00PM"),
                             :end_time => Time.parse("Jan 1st 1:10PM"))
    end

    should "be satisfied if meets minimum duration" do
      @rule.update_attribute(:min_duration, 9.minutes)
      assert_equal true, @rule.satisfied?
    end

    should "be satisfied if meets maximum duration" do
      @rule.update_attribute(:max_duration, 11.minutes)
      assert_equal true, @rule.satisfied?
    end

    should "be satisfied if meets minimum and maximum duration" do
      @rule.update_attribute(:min_duration, 9.minutes)
      @rule.update_attribute(:max_duration, 11.minutes)
      assert_equal true, @rule.satisfied?
    end

    should "not be satisfied if violates minimum duration" do
      @rule.update_attribute(:min_duration, 12.minutes)
      assert_equal false, @rule.satisfied?
    end

    should "not be satisfied if violates maximum duration" do
      @rule.update_attribute(:max_duration, 8.minutes)
      assert_equal false, @rule.satisfied?
    end
  end
end
