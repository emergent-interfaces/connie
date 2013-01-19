require 'test_helper'

class ReservesTaggedRuleTest < ActiveSupport::TestCase
  should validate_presence_of :tagged_type
  should validate_presence_of :tag_name

  context "with an event" do
    setup do
      @event = FactoryGirl.create(:event)
    end

    should "not be satisfied with no reservations" do
      @rule = ReservesTaggedRule.new(:tagged_type => "space", :tag_name => "has projector")
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)

      refute @rule.satisfied?
    end
  end

  context "with an event and space" do
    setup do
      @event = FactoryGirl.create(:event)
      @space = FactoryGirl.create(:space)

      @event.reservations.create!(:reservable => @space, :inherit_time_span => true)
    end

    should "not be satisfied if space has no tags" do
      @rule = ReservesTaggedRule.new(:tagged_type => "space", :tag_name => "has projector")
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)

      refute @rule.satisfied?
    end

    should "not be satisfied if space has wrong tags" do
      @rule = ReservesTaggedRule.new(:tagged_type => "space", :tag_name => "has projector")
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)

      @space.tag_list = "has cows, has sheep"
      @space.save

      refute @rule.satisfied?
    end

    should "be satisfied if space has the right tag" do
      @rule = ReservesTaggedRule.new(:tagged_type => "space", :tag_name => "has projector")
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)

      @space.tag_list = "has projector"
      @space.save

      assert @rule.satisfied?
    end

  end
end
