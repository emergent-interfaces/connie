require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should validate_presence_of :name

  should belong_to :convention
  should validate_presence_of :convention

  should have_db_column :department

  should belong_to :profile
  should validate_presence_of :profile
end
