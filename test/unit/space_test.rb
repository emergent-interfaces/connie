require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should belong_to :parent

  should have_many :reservations

  should have_db_column(:parent_id).of_type(:integer)
  should have_db_column(:lft).of_type(:integer)
  should have_db_column(:rgt).of_type(:integer)
  should have_db_column(:depth).of_type(:integer)

  should validate_presence_of :space_type
  should allow_value("building").for(:space_type)
  should allow_value("floor").for(:space_type)
  should allow_value("area").for(:space_type)
  should allow_value("room").for(:space_type)
  should_not allow_value("hurkburjurgur").for(:space_type)
  should_not allow_value("bajizzlestein").for(:space_type)
end
