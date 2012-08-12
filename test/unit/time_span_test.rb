require 'test_helper'

class TimeSpanTest < ActiveSupport::TestCase
  should validate_presence_of :start_time
  should validate_presence_of :end_time
  should validate_presence_of :confidence
  should belong_to :time_spanable

  context "with a TimeSpan" do
    setup do
      @ts = TimeSpan.new(:start_time => Time.parse("Jan 1"),
                         :end_time => Time.parse("Jan 5"),
                         :confidence => 2)
    end

    should "provide span" do
      @ts.start_time = Time.parse("Jan 1")
      @ts.end_time = Time.parse("Jan 5")
      assert_equal Time.parse("Jan 1")...Time.parse("Jan 5"), @ts.span
    end

    should "be invalid if end_time before start_time" do
      @ts.start_time = Time.parse("Jan 7")
      @ts.end_time = Time.parse("Jan 5")
      refute @ts.valid?
    end

    should "be invalid if end_time equals start_time" do
      @ts.start_time = Time.parse("Jan 5")
      @ts.end_time = Time.parse("Jan 5")
      refute @ts.valid?
    end

    should "be valid if start_time before end_time" do
      @ts.start_time = Time.parse("Jan 1")
      @ts.end_time = Time.parse("Jan 5")
      assert @ts.valid?
    end

    context "when calculating duration" do
      setup do
        @ts.start_time = Time.parse("Jan 1, 2011 9:00AM")
        @ts.end_time = Time.parse("Jan 1, 2011 10:30AM")
      end

      should "should present in default seconds" do
        assert_equal 5400, @ts.duration()
      end

      should "should present in seconds" do
        assert_equal 5400, @ts.duration(:seconds)
      end

      should "should present in minutes" do
        assert_equal 90, @ts.duration(:minutes)
      end

      should "should present in hours" do
        assert_equal 1.5, @ts.duration(:hours)
      end
    end
  end

  context "with multiple TimeSpans" do
    setup do
      @ts1 = TimeSpan.new(:start_time => Time.parse("Jan 1"),
                         :end_time => Time.parse("Jan 5"),
                         :confidence => 2)
      @ts2 = TimeSpan.new(:start_time => Time.parse("Jan 12"),
                         :end_time => Time.parse("Jan 20"),
                         :confidence => 2)
      @ts3 = TimeSpan.new(:start_time => Time.parse("Jan 7"),
                         :end_time => Time.parse("Jan 13"),
                         :confidence => 2)
    end

    should "be during if it is contained by a TimeSpan in an array" do
      @ts = TimeSpan.new(:start_time => Time.parse("Jan 15"),
                         :end_time => Time.parse("Jan 18"),
                         :confidence => 2)

      assert @ts.is_during?([@ts1, @ts2])
    end

    should "not be during if it is not contained by a TimeSpan in an array" do
      @ts = TimeSpan.new(:start_time => Time.parse("Jan 8"),
                         :end_time => Time.parse("Jan 10"),
                         :confidence => 2)

      refute @ts.is_during?([@ts1, @ts2])
    end

    should "know if is before another event" do
      assert_equal true, @ts1.before?(@ts2)
    end

    should "know if is not before another event" do
      assert_equal false, @ts2.before?(@ts1)
    end

    should "know if is after another event" do
      assert_equal true, @ts2.after?(@ts1)
    end

    should "know if is not after another event" do
      assert_equal false, @ts1.after?(@ts2)
    end
  end

  context "with edge case TimeSpans" do
    setup do
      @ts1 = TimeSpan.new(:start_time => Time.parse("Jan 1 2pm"),
                          :end_time => Time.parse("Jan 1 3pm"),
                          :confidence => 2)
      @ts2 = TimeSpan.new(:start_time => Time.parse("Jan 1 3pm"),
                          :end_time => Time.parse("Jan 1 4pm"),
                          :confidence => 2)
      @ts3 = TimeSpan.new(:start_time => Time.parse("Jan 1 4pm"),
                          :end_time => Time.parse("Jan 1 5pm"),
                          :confidence => 2)
    end

    should "know if is before another event" do
      assert_equal true, @ts1.before?(@ts2)
    end

    should "know if is not before another event" do
      assert_equal false, @ts2.before?(@ts1)
    end

    should "know if is after another event" do
      assert_equal true, @ts2.after?(@ts1)
    end

    should "know if is not after another event" do
      assert_equal false, @ts1.after?(@ts2)
    end
  end

end