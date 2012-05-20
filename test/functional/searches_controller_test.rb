require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    should "be able to display a list of search results" do
      get :show, {:text => 'test'}

      assert assigns :search
    end
  end
end
