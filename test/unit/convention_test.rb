require 'test_helper'

class ConventionTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_uniqueness_of :name

end
