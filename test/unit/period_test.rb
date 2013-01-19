require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  should have_one :time_span
  should belong_to :convention
  should validate_presence_of :name
  should validate_presence_of :time_span

  should allow_value(nil).for(:special)
  should allow_value("").for(:special)
  should allow_value("planning").for(:special)
  should allow_value("production").for(:special)
  should allow_value("running").for(:special)
  should allow_value("wrap").for(:special)
  should_not allow_value("hurkburjurgur").for(:special)
  should_not allow_value("bajizzlestein").for(:special)

  should "have a set of special period types" do
    assert_equal ["planning", "production", "running", "wrap"], Period::SPECIAL_PERIODS
  end
end
