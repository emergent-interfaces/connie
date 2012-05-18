require 'test_helper'

class RulesControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    should "be able to delete a Rule and RuleAssignment from the Rule" do
      @event = FactoryGirl.create(:event)
      @rule = BeScheduledRule.new
      @event.rule_assignments << RuleAssignment.new(:rule => @rule)

      assert_difference('BeScheduledRule.all.count',-1) do
        assert_difference('@event.rule_assignments.count', -1) do
          delete :destroy, {:rule_id => @rule.id, :rule_type => @rule.class}
        end
      end

      assert redirect_to @event
    end
  end
end