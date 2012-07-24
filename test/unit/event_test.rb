require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should have_many(:conventions).through(:convention_linkables)
  should have_one(:time_span)
  should have_many(:reservations)

  should "know if scheduled" do
    event = FactoryGirl.create(:event)
    time_span = FactoryGirl.create(:time_span)
    event.expects(:time_span).returns(time_span)
    assert_equal true, event.scheduled?
  end

  should "know if not scheduled" do
    event = FactoryGirl.create(:event)
    assert_equal false, event.scheduled?
  end
end
