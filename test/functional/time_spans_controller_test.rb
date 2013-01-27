require 'test_helper'

class TimeSpansControllerTest < ActionController::TestCase

  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    should "create new TimeSpan with natural language" do
      @event = FactoryGirl.create(:event)

      Time.zone = 'Pacific Time (US & Canada)'
      puts Time.zone

      assert_difference('TimeSpan.count') do
        post :create, {:time_span => {:start_time => "Jan 1st 2001 at 1AM",
                                      :end_time => "Jan 1st 2001 at 2:30AM",
                                      :confidence => 1},
                       :event_id => @event.id}
      end

      assert_equal Time.parse("2001-01-01 6:00:00 UTC"), @event.time_span.start_time
      assert_equal Time.parse("2001-01-01 7:30:00 UTC"), @event.time_span.end_time
    end

    context "for an Event" do
      setup do
        @event = FactoryGirl.create(:event)
      end

      should "get new TimeSpan" do
        get :new, {:event_id => @event.id}
        assert :success
        assert assigns :time_span
        assert assigns :event
      end

      should "create new TimeSpan" do
        assert_difference('TimeSpan.count') do
          post :create, {:time_span => {:start_time => Time.parse("Jan 1"),
                                       :end_time => Time.parse("Jan 5"),
                                       :confidence => 1},
                         :event_id => @event.id}
        end

        assert @event.time_span
        assert_equal 1, @event.time_span.confidence
      end

      should "fail to create an invalid TimeSpan" do
        assert_difference('TimeSpan.count', 0) do
          post :create, {:time_span => {:start_time => Time.parse("Jan 7"),
                                       :end_time => Time.parse("Jan 5"),
                                       :confidence => 2},
                         :event_id => @event.id}
        end

        assert_template :new
      end

      context "with a TimeSpan" do
        setup do
            @event.create_time_span({:start_time => Time.parse("Jan 1"),
                                     :end_time => Time.parse("Jan 5"),
                                     :confidence => 2})
        end

        should "delete a TimeSpan" do
          assert_difference('TimeSpan.count', -1) do
            delete :destroy, {:event_id => @event.id}
          end
        end
      end

    end
  end
end
