require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should have_many :taggings
  should belong_to :tag_group

  should "be able to locate tag in group" do
    tag_group = FactoryGirl.create(:tag_group,:name=>'Tag Group 1')
    tag = FactoryGirl.create(:tag,:name=>'Example Tag', :tag_group => tag_group)

    found_tag = Tag.find_by_group_and_tag_name("Tag Group 1", "Example Tag")
    assert_equal tag, found_tag
  end
end
