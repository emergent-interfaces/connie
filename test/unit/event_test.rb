require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should have_many(:conventions).through(:convention_events)
end
