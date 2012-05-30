require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    should "get list of profiles" do
      get :index
      assert assigns :profiles
    end

    should "get new profile" do
      get :new
      assert assigns :profile
    end

    should "create a profile with good data" do
      assert_difference('Profile.count') do
        post :create, {:profile=> {:name => 'Ron Burgandy'}}
      end

      assert_redirected_to assigns :profile
    end

    should "not create a profile with bad data" do
      assert_difference('Profile.count',0) do
        post :create, {:profile=> {}}
      end

      assert_template :new
    end

    context "with some profiles" do
      setup do
        @p1 = FactoryGirl.create :profile
        @p2 = FactoryGirl.create :profile
        @p3 = FactoryGirl.create :profile
      end

      should "get a profile" do
        get :show, {:id => @p1.id}
        assert assigns :profile
      end

      should "edit a profile" do
        get :edit, {:id => @p1.id}
        assert assigns :profile
      end

      should "update a profile" do
        put :update, {:id => @p1.id, :profile => {:name => 'Bob Barker'}}
        assert assigns :profile
        assert_equal 'Bob Barker', assigns(:profile).name
      end

      should "delete a profile" do
        assert_difference('Profile.count',-1) do
          delete :destroy, {:id => @p1.id}
        end

        assert_redirected_to profiles_path
      end
    end
  end
end
