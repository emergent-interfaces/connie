require 'test_helper'

class ConventionLinkableTest < ActiveSupport::TestCase
  should belong_to :convention
  should belong_to :linkable
  should have_db_column :linkable_type
end
