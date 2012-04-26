require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  should validate_presence_of :name
  #should validate_presence_of :venue_designated_name
  should belong_to :parent

  should have_many :reservations

  should have_db_column(:parent_id).of_type(:integer)
  should have_db_column(:lft).of_type(:integer)
  should have_db_column(:rgt).of_type(:integer)
  should have_db_column(:depth).of_type(:integer)
end
