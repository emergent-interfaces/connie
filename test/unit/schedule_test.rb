require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  should belong_to :convention
  should validate_presence_of :convention

  should belong_to :time_span
  should validate_presence_of :time_span

  should validate_presence_of :name

  should have_many :schedule_reservables
  should have_many :spaces
  should have_many :profiles

  context "with some reservations and schedule" do
    setup do
      @s1 = FactoryGirl.create(:space)

      time_span = FactoryGirl.create(:time_span,
                                     :start_time => Time.parse("Jan 1 10am"),
                                     :end_time => Time.parse("Jan 1 11am"))
      @e1 = FactoryGirl.create(:event, :time_span => time_span)
      time_span = FactoryGirl.create(:time_span,
                                     :start_time => Time.parse("Jan 1 11am"),
                                     :end_time => Time.parse("Jan 1 12pm"))
      @e2 = FactoryGirl.create(:event, :time_span => time_span)

      @r1 = FactoryGirl.create(:reservation, :reservee => @e1, :reservable => @s1)
      @r2 = FactoryGirl.create(:reservation, :reservee => @e2, :reservable => @s1)

      @c = FactoryGirl.create(:convention)

      time_span = FactoryGirl.create(:time_span,
                                     :start_time => Time.parse("Jan 1 8am"),
                                     :end_time => Time.parse("Jan 1 1pm"))
      @schedule = FactoryGirl.create(:schedule, :convention => @c, :time_span => time_span)
    end

    should "collect reservations" do
      assert_equal [@r1, @r2], @schedule.reservations
    end

    should "collect critical times" do
      assert_equal [@e1.time_span.start_time,@e2.time_span.start_time,@e2.time_span.end_time],
                   @schedule.critical_times
    end
  end
end