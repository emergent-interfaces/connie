require 'test_helper'

class PhonesControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with a profile" do
      setup do
        @profile = FactoryGirl.create(:profile)
      end

      should "get new phone" do
        get :new, {:profile_id => @profile.id}
        assert assigns :phone
      end

      should "create a phone with good data" do
        assert_difference('Phone.count') do
          post :create, {:profile_id => @profile.id,
                         :phone=> {:number => '1234567890'}}
        end

        assert_redirected_to assigns :phoneable
      end

      context "with a Phone" do
        setup do
          @phone = @profile.phones.create!(:number=>'1234567890')
        end

        should "edit a Phone" do
          get :edit, {:profile_id => @profile.id,
                      :id => @phone.id}
          assert_equal @profile, assigns(:phoneable)
          assert assigns :phone
        end

        should "update a Phone" do
          put :update, {:profile_id => @profile.id,
                        :id => @phone.id,
                        :phone => {:number => '1111111111'}}
          assert assigns :phone
          assert_equal '1111111111', assigns(:phone).number
        end

        should "delete a Phone" do
          assert_difference('Phone.count',-1) do
            delete :destroy, {:profile_id => @profile.id,
                              :id => @phone.id}
          end

          assert_redirected_to @profile
        end
      end
    end

  end
end
