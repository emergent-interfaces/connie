require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  context "with an event" do
    setup do
      @event = FactoryGirl.create(:event)
    end

    should "be able to add a BeScheduledRule" do
      assert_difference('@event.rule_assignments.count') do
        post :create_rule, {:event_id => @event.id, :rule_type => 'BeScheduledRule'}
      end

      assert redirect_to @event
    end

  end
end
