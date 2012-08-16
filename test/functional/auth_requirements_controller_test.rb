require 'test_helper'

class AuthRequirementsControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with an AuthRequirement" do
      setup do
        @con = FactoryGirl.create(:convention)
        @ar = @con.auth_requirements.create(:action => "edit", :model => "something")
      end

      should "get edit" do
        get :edit, :convention_id => @con.id, :id => @ar.id
      end

      should "update requirement" do
        put :update, :convention_id => @con.id,
                     :id => @ar.id,
                     :auth_requirement => {
                        :requirement => "a/v tech: staff"
                     }
      end
    end
  end
end
