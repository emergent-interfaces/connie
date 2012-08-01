require 'test_helper'

class PeriodsControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with a Convention" do
      setup do
        @convention = FactoryGirl.create(:convention)
      end

      should "get new Period" do
        get :new, :convention_id => @convention.id

        assert :success
        assert assigns :convention
        assert assigns :period
      end

      should "be able to create Period" do
        assert_difference('Period.count') do
          post :create, :convention_id => @convention.id, :period => {
              :name => "Test Period",
              :time_span_attributes => {
                  :start_time => "Jan 1st 1PM",
                  :end_time => "Jan 1st at 2PM",
                  :confidence => 0}
          }
        end

        assert_redirected_to @convention
      end

      should "not be able to create Period with bad data" do
        assert_difference('Period.count',0) do
          post :create, :convention_id => @convention.id, :period => {}
        end

        assert render_template :new
      end

      context "with a period" do
        setup do
          @period = FactoryGirl.create(:period, :convention => @convention)
        end

        should "get Period edit page" do
          get :edit, :convention_id => @convention.id, :id => @period.id

          assert assigns :convention
          assert assigns :period
        end

        should "be able to update Period" do
          put :update, :convention_id => @convention.id, :id => @period.id,
                       :period => {:name => "New Name"}

          assert redirect_to @convention
        end

        should "be able to delete Period" do
          assert_difference('Period.count',-1) do
            delete :destroy, :convention_id => @convention.id, :id => @period.id
          end

          assert redirect_to @convention
        end
      end
    end
  end
end
