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
end