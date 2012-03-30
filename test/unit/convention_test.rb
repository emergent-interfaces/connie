require 'test_helper'

class ConventionTest < ActiveSupport::TestCase
  should validate_presence_of :name

  Factory(:convention)  # required to validate_uniqueness
  should validate_uniqueness_of :name

  should have_many(:events).through(:convention_events)
end
