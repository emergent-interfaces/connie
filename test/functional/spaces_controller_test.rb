require 'test_helper'

class SpacesControllerTest < ActionController::TestCase
  context "when no Spaces exist" do
    setup do

    end
  end

  context "when Spaces exist" do
    setup do
      @world = FactoryGirl.create(:space, :name=>'world')
      @space1 = FactoryGirl.create(:space, :parent=>@world)
      @space2 = FactoryGirl.create(:space, :parent=>@space1)
    end

    should "get index" do
      get :index
      assert_response :success
      assert assigns :spaces
    end

    should "get show" do
      get :show, {:id => @space1.id}
      assert_response :success
      assert assigns(:space)
    end

    should "get edit" do
      get :edit, {:id => @space1.id}
      assert_response :success
      assert assigns(:space)
    end

    should "create new Space with a parent" do
      assert_difference('Space.count') do
        post :create, :space => {:name => "New Space",
                                 :venue_designated_name => "New Venue Space",
                                 :parent_id => @space1.id}
      end

      new_space = assigns(:space)
      assert_redirected_to new_space
      assert_equal @space1, new_space.parent
    end

    should "update Space" do
      put :update, {:id => @space1.id,
                    :space => {:name => "New Space Name"}
      }

      assert_redirected_to assigns(:space)
    end

    should "be able to delete space" do
      assert_difference('Space.count', -1) do
        delete :destroy, :id => @space2.id
      end

      assert_redirected_to spaces_path
    end

    should "be able to delete space and children" do
      assert_difference('Space.count', -2) do
        delete :destroy, :id => @space1.id
      end

      assert_redirected_to spaces_path
    end
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create new Space with the World as parent if no parent given" do
    world = FactoryGirl.create(:space,:name=>"world")
    Space.expects(:find_by_name).with('world').returns(world)

    assert_difference('Space.count') do
      post :create, :space => {:name => "New Space", :venue_designated_name => "New Venue Space"}
    end

    new_space = assigns(:space)
    assert_redirected_to new_space
    assert_equal world, new_space.parent
  end
end
