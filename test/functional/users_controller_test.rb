require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @signed_in_user = FactoryGirl.create(:user)
      sign_in @signed_in_user
    end

    context "with a user" do
      setup do
        @user = FactoryGirl.create(:user)
      end

      should "get index" do
        get :index
        assert assigns :users
      end

      should "get user" do
        get :show, {:id => @user.id}

        assert assigns(:user)
        assert_equal @user, assigns(:user)
      end

      should "edit user" do
        get :edit, {:id => @user.id}
        assert assigns(:user)
      end

      should "update user" do
        put :update, {:id => @user.id, :user=>{username: 'Bruce Lee'}}

        assert_equal 'Bruce Lee', @user.username
      end
    end
  end
end
