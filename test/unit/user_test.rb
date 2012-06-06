require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to :profile
end
