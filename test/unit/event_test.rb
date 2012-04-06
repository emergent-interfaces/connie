require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should have_many(:conventions).through(:convention_resourceables)
  should have_one(:time_span)
end
