require 'test_helper'

class RolesControllerTest < ActionController::TestCase
  context "with a logged in User" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with a Profile and Convention" do
      setup do
        @profile = FactoryGirl.create(:profile)
        @convention = FactoryGirl.create(:convention)
      end

      should "get new Role" do
        get :new, {:profile_id => @profile.id}
        assert assigns :profile
        assert assigns :role
      end

      should "get new Role with default Convention" do
        get :new, {:profile_id => @profile.id, :convention_id => @convention.id}
        assert assigns :profile
        assert assigns :role
        assert_equal @convention, assigns(:role).convention
      end

      should "create a Role" do
        assert_difference('Role.count') do
          post :create, {:role => {:name => "Staff",
                                   :profile_id => @profile.id,
                                   :convention_id => @convention.id}}
        end

        assert redirect_to @profile
      end

      context "with a Role" do
        setup do
          @role = @profile.roles.create(name: 'staff',
                                        profile_id: @profile.id,
                                        convention_id: @convention.id)
        end

        should "delete a Role" do
          assert_difference('Role.count',-1) do
            delete :destroy, {:id => @role.id}
          end
          assert redirect_to @profile
        end
      end
    end
  end
end
