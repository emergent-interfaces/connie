require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  should belong_to :reservable
  should belong_to :event
end
