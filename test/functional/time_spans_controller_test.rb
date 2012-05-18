require 'test_helper'

class TimeSpansControllerTest < ActionController::TestCase

  # todo Implement convention TimeSpans
  #context "for a Convention" do
  #  setup do
  #    @convention = FactoryGirl.create(:convention)
  #  end
  #
  #  should "get new TimeSpan" do
  #    get :new, {:event_id => @event.id}
  #    assert :success
  #    assert assigns :time_span
  #    assert assigns :event
  #  end
  #
  #  should "create new TimeSpan" do
  #    assert_difference('TimeSpan.count') do
  #      post :create, {:time_span => {:start_time => Time.parse("Jan 1"),
  #                                   :end_time => Time.parse("Jan 5"),
  #                                   :confidence => 2},
  #                     :convention_id => @convention.id}
  #    end
  #
  #    assert_equal 1, @convention.time_spans.count
  #  end
  #
  #  should "fail to create an invalid TimeSpan" do
  #    assert_difference('TimeSpan.count', 0) do
  #      post :create, {:time_span => {:start_time => Time.parse("Jan 7"),
  #                                   :end_time => Time.parse("Jan 5"),
  #                                   :confidence => 2},
  #                     :convention_id => @convention.id}
  #    end
  #
  #    assert_template :new
  #  end
  #
  #  context "with a TimeSpan" do
  #    setup do
  #      @time_span = @convention.time_spans.create({:start_time => Time.parse("Jan 1"),
  #                                   :end_time => Time.parse("Jan 5"),
  #                                   :confidence => 2})
  #    end
  #
  #    should "delete a TimeSpan" do
  #      assert_difference('TimeSpan.count', -1) do
  #        delete :destroy, {:convention_id => @convention.id, :id => @time_span.id}
  #      end
  #
  #      assert_equal 0, @convention.time_spans.count
  #    end
  #  end
  #
  #end
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
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
