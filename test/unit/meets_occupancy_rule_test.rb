require 'test_helper'

class MeetsOccupancyRuleTest < ActiveSupport::TestCase
  should have_one(:rule_assignment).dependent(:destroy)
  should validate_presence_of :arrangement
  should validate_presence_of :capacity

  context "with an Event" do
    setup do
      @event = FactoryGirl.create(:event)
    end

    should "be satisfied when Event reserves a space with enough capacity" do
      @rule = MeetsOccupancyRule.new(:arrangement => "standing", :capacity => 10)
      @rule_assignment = RuleAssignment.new(:rule => @rule)
      @event.rule_assignments << @rule_assignment

      refute @rule.satisfied?

      @space = FactoryGirl.create(:space, :occupancy_standing => 20)
      @event.reservations.create!(:reservable => @space, :inherit_time_span => true)
      @rule.reload

      assert @rule.satisfied?
    end

  end
end
