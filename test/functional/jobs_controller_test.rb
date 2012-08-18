require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:admin_user)
      sign_in @user
    end

    should "get list of Jobs" do
      get :index
      assert assigns :jobs
    end

    should "get new Job" do
      get :new
      assert assigns :job
    end

    should "create a Job with good data" do
      assert_difference('Job.count') do
        post :create, {:job => {:name => 'Do a barrel roll'}}
      end

      assert_redirected_to assigns :job
    end

    context "with a Job" do
      setup do
        @job = FactoryGirl.create(:job)
      end

      should "get a Job" do
        get :show, {:id => @job.id}
        assert assigns :job
      end

      should "edit a Job" do
        get :edit, {:id => @job.id}
        assert assigns :job
      end

      should "update a Job" do
        put :update, {:id => @job.id, :job => {:name => 'Press R or Z twice'}}
        assert assigns :job
        assert_equal 'Press R or Z twice', assigns(:job).name
      end

      should "delete a Job" do
        assert_difference('Job.count',-1) do
          delete :destroy, {:id => @job.id}
        end

        assert_redirected_to jobs_path
      end
    end
  end
end
