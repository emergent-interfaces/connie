require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with a convention" do
      setup do
        @convention = FactoryGirl.create(:convention)
      end

      should "get a new schedule page" do
        get :new, :convention_id => @convention.id

        assert render_template :new
        assert assigns :convention
        assert assigns :schedule
      end

      should "create a new schedule with good info" do
        assert_difference('Schedule.count') do
          post :create, :convention_id => @convention.id,
                        :schedule => {
                          :name => 'Test Schedule',
                          :time_span_attributes => {
                            :start_time => Time.parse("Jan 1 1pm"),
                            :end_time => Time.parse("Jan 1 2pm"),
                            :confidence => 0
                          }
                        }
        end

        assert redirect_to [assigns(:convention), assigns(:schedule)]
      end

      should "fail to create a new schedule with bad info" do
        assert_difference('Schedule.count',0) do
          post :create, :convention_id => @convention.id,
               :schedule => {
                   :name => "",
                   :time_span_attributes => {
                       :start_time => Time.parse("Jan 1 1pm"),
                       :end_time => Time.parse("Jan 1 2pm"),
                       :confidence => 0
                   }
               }
        end

        assert redirect_to [assigns(:convention), assigns(:schedule)]
      end

      context "with a schedule" do
        setup do
          @schedule = FactoryGirl.create(:schedule, :convention => @convention)
        end

        should "get edit page" do
          get :edit, :convention_id => @convention.id, :id => @schedule.id

          assert assigns :convention
          assert assigns :schedule
        end

        should "perform edit with good data" do
          put :update, :convention_id => @convention.id, :id => @schedule.id,
                          :schedule => {
                              :name => "Something new"
                              }

          assert redirect_to [@convention, @schedule]
        end

        should "be able to delete schedule" do
          assert_difference('Schedule.count',-1) do
            delete :destroy, :convention_id => @convention.id, :id => @schedule.id
          end

          assert redirect_to @convention
        end
      end
    end

  end
end
