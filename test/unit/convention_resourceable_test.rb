require 'test_helper'

class ConventionResourceableTest < ActiveSupport::TestCase
  should belong_to :convention
  should belong_to :resourceable
  should have_db_column :resourceable_type
end
