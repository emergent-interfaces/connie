require 'test_helper'

class MapsControllerTest < ActionController::TestCase
  context "with a logged in user and space" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user

      @space = FactoryGirl.create(:space)
    end

    should "get new Map" do
      get :new, :space_id => @space.id
      assert assigns :map
    end

    should "create Map" do
      assert_difference("Map.count") do
        post :create, :space_id => @space.id, :map => {:image => fixture_file_upload('test.png')}
      end
      assert redirect_to(assigns :space)
    end

    context "with a Map" do
      setup do
        @map = FactoryGirl.create(:map, :space=>@space)
      end

      should "show Map" do
        get :show, :space_id => @space.id, :id => @map.id
        assert assigns :space
        assert assigns :map
      end

      should "edit Map" do
        get :edit, :space_id => @space.id, :id => @map.id
        assert_equal @map, assigns(:map)
      end

      should "update Map" do
        put :update, :space_id => @space.id, :id => @map.id, :map => {}
        assert redirect_to @map
      end

      should "delete Map" do
        assert_difference("Map.count", -1) do
          delete :destroy, :space_id => @space.id, :id => @map.id
        end
        assert redirect_to @space
      end
    end
  end
end
