require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  should belong_to :reservable
  should belong_to :event

  context "with a Space, Event, and TimeSpan" do
    setup do
      @event = FactoryGirl.create(:event)
      @space = FactoryGirl.create(:space)

      @time_span = TimeSpan.create(:start_time => Time.parse('July 1st'),
                                   :end_time => Time.parse('July 2nd'),
                                   :confidence => 0)
    end

    should "be able to specify a TimeSpan" do
      @reservation = @event.reservations.build(:reservable => @space, :time_span => @time_span)
      assert_equal @time_span, @reservation.time_span
    end

    should "inherit reservation if specified" do
      @event = FactoryGirl.create(:event, :time_span => @time_span)
      @reservation = @event.reservations.build(:reservable => @space, :inherit_time_span => true)
      assert_equal @time_span, @reservation.time_span
    end

    should "be scheduled when has its timespan set" do
      @reservation = @event.reservations.build(:reservable => @space, :time_span => @time_span)
      assert @reservation.scheduled?
    end

    should "be scheduled when inherits a timespan" do
      @event = FactoryGirl.create(:event, :time_span => @time_span)
      @reservation = @event.reservations.build(:reservable => @space, :inherit_time_span => true)
      assert @reservation.scheduled?
    end

    should "not be scheduled when inherits from an unscheduled model" do
      @event = FactoryGirl.create(:event)
      @reservation = @event.reservations.build(:reservable => @space, :inherit_time_span => true)
      refute @reservation.scheduled?
    end

    should "not be scheduled when has no TimeSpan and does not inherit" do
      @reservation = @event.reservations.build(:reservable => @space)
      refute @reservation.scheduled?
    end
  end

end
