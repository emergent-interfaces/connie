require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "with a user" do
    setup do
      User.destroy_all
      @user = FactoryGirl.create(:user)
    end

    should "get user" do
      get :show, {:id => @user.id}

      assert assigns :user
      assert_equal @user, assigns(:user)
    end
  end

  should "get index" do
      get :index
      assert assigns :users
  end
end
