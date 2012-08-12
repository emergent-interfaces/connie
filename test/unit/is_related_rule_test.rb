require 'test_helper'

class IsRelatedRuleTest < ActiveSupport::TestCase
  should belong_to(:related_event)
  should validate_presence_of(:related_event)
  should have_one(:event).through(:rule_assignment)

  should allow_value("before").for(:relation)
  should allow_value("after").for(:relation)
  should_not allow_value("").for(:relation)
  should_not allow_value("asdf").for(:relation)

  context "with an event assigned as IsRelatedRule and a related event" do
    setup do
      @event = FactoryGirl.create(:event, :name => "Ruled Event")
      @related_event = FactoryGirl.create(:event, :name => "Related Event")

      @rule = IsRelatedRule.create(:related_event => @related_event, :relation => 'before')
      @rule_assignment = RuleAssignment.create(:rule => @rule, :event => @event)
    end

    should "be able to set relation to another event" do
      another_event = FactoryGirl.create(:event, :name => "Another Event")
      @rule.related_event = another_event
      assert @rule.save
    end

    should "be violated if event is not scheduled" do
      @event.stubs('scheduled?').returns(false)
      @related_event.stubs('scheduled?').returns(true)
      assert @rule.violated?
    end

    should "be violated if related event is not scheduled" do
      @event.stubs('scheduled?').returns(true)
      @related_event.stubs('scheduled?').returns(false)
      assert @rule.violated?
    end

    should "be satisfied if 'after' relation is ok" do
      @rule.relation = 'after'
      @rule.save

      ts1 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1'),
                               :end_time => Time.parse('Jan 2'))
      ts2 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 5'),
                               :end_time => Time.parse('Jan 6'))
      @event.time_span = ts2
      @event.save
      @related_event.time_span = ts1
      @related_event.save

      assert_equal true, @rule.satisfied?
    end

    should "be satisfied if 'after' relation on edge case is ok" do
      @rule.relation = 'after'
      @rule.save

      ts1 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1 2pm'),
                               :end_time => Time.parse('Jan 1 3pm'))
      ts2 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1 3pm'),
                               :end_time => Time.parse('Jan 1 4pm'))
      @event.time_span = ts2
      @event.save
      @related_event.time_span = ts1
      @related_event.save

      assert_equal true, @rule.satisfied?
    end

    should "be satisfied if 'before' relation is ok" do
      @rule.relation = 'before'
      @rule.save

      ts1 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1'),
                               :end_time => Time.parse('Jan 2'))
      ts2 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 5'),
                               :end_time => Time.parse('Jan 6'))
      @event.time_span = ts1
      @event.save
      @related_event.time_span = ts2
      @related_event.save

      assert_equal true, @rule.satisfied?
    end

    should "be satisfied if 'before' relation on edge case is ok" do
      @rule.relation = 'before'
      @rule.save

      ts1 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1 2pm'),
                               :end_time => Time.parse('Jan 1 3pm'))
      ts2 = FactoryGirl.create(:time_span,
                               :start_time => Time.parse('Jan 1 3pm'),
                               :end_time => Time.parse('Jan 1 4pm'))
      @event.time_span = ts1
      @event.save
      @related_event.time_span = ts2
      @related_event.save

      assert_equal true, @rule.satisfied?
    end
  end
end
