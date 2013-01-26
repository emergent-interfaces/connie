require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  should have_one :time_span
  should belong_to :convention
  should validate_presence_of :name
  should validate_presence_of :time_span
end