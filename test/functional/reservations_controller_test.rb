require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    context "with an Event" do
      setup do
        @event = FactoryGirl.create(:event)
      end

      should "default to inheriting the TimeSpan" do
        get :new, {:event_id => @event.id}
        assert_equal true, assigns(:reservation).inherit_time_span
      end

      should "get new Reservation" do
        get :new, {:event_id => @event.id}

        assert :success
        assert assigns :reservation
      end

      context "with a Profile" do
        setup do
          @profile = FactoryGirl.create(:profile)
        end

        should "create new Reservation with valid data" do
          assert_difference('@event.reservations.count') do
            post :create, {:event_id => @event.id,
                           :reservation => {:reservable_id => "#{@profile.class}-#{@profile.id}",
                                            :inherit_time_span => true}
                           }
          end
        end

        should "not create new Reservation without inheriting and no TimeSpan" do
          assert_difference('@event.reservations.count', 0) do
            post :create, {:event_id => @event.id,
                           :reservation => {:reservable_id => "#{@profile.class}-#{@profile.id}",
                                            :inherit_time_span => false}
            }
          end

          assert render_template :new
        end
      end

      context "with a Space" do
        setup do
          @space = FactoryGirl.create(:space)
        end

        should "create new Reservation with valid data" do
          assert_difference('@event.reservations.count') do
            post :create, {:event_id => @event.id,
                           :reservation => {:reservable_id => "#{@space.class}-#{@space.id}",
                                            :inherit_time_span => true}
                           }
          end

          assert_redirected_to @event
          assert_equal'Space', @event.reservations[0].reservable_type
          assert_equal @space.id, @event.reservations[0].reservable_id
          assert_equal @space, @event.reservations[0].reservable
        end

        should "create be able to specify its own TimeSpan" do
          assert_difference('@event.reservations.count') do
            post :create, {:event_id => @event.id, :reservation => {
                            :reservable_id => "#{@space.class}-#{@space.id}",
                            :inherit_time_span => false,
                            :own_time_span_attributes => {
                               :start_time => "Jan 1st 1PM",
                               :end_time => "Jan 1st at 2PM",
                               :confidence => 0}
                          }
            }
          end

          assert_redirected_to @event
          assert_equal Time.parse('Jan 1st 1PM'), @event.reservations[0].time_span.start_time
          assert_equal Time.parse('Jan 1st 2PM'), @event.reservations[0].time_span.end_time
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
            @reservation = FactoryGirl.create(:reservation, reservee: @event)
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
end