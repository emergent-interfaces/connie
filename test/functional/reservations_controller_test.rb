require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  context "with an Event" do
    setup do
      @event = FactoryGirl.create(:event)
    end

    should "get new Reservation" do
      get :new, {:event_id => @event.id}

      assert :success
      assert assigns :reservation
    end

    context "with a Space" do
      setup do
        @space = FactoryGirl.create(:space)
      end

      should "create new Reservation with valid data" do
        assert_difference('@event.reservations.count') do
          post :create, {:event_id => @event.id,
                         :reservation => {:reservable_id => @space.id}}
        end

        assert_redirected_to @event
        assert_equal'space', @event.reservations[0].reservable_type
        assert_equal @space.id, @event.reservations[0].reservable_id
        assert_equal @space, @event.reservations[0].reservable
      end

      should "fail to create new Reservation with no reservable" do
        assert_difference('@event.reservations.count', 0) do
          post :create, {:event_id => @event.id,
                         :reservation => {:reservable_id => ""}}
        end

        assert_template :new
      end

      context "with a Reservation" do
        setup do
          @reservation = FactoryGirl.create(:reservation)
        end

        should "destroy Reservation" do
          assert_difference('Reservation.count', -1) do
            delete :destroy, {:event_id => @event.id,
                              :id => @reservation.id}
          end

          assert_redirected_to @event
        end
      end
      
    end
  end
end