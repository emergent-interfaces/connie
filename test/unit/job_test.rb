require 'test_helper'

class JobTest < ActiveSupport::TestCase
  should validate_presence_of :name
end
