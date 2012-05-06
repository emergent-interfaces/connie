require 'test_helper'

class SpacesHelperTest < ActionView::TestCase
  context "with a set of spaces" do
    setup do
      @s1 = Space.create(name: 'Stevens Campus', space_type: 'area')
      @s2 = Space.create(name: 'Babbio Center', space_type: 'building', parent: @s1)
      @s3 = Space.create(name: '1st Floor', space_type: 'floor', parent: @s2)
      @s4 = Space.create(name: 'Main Events', space_type: 'room', parent: @s3)
    end

    should "generate full location" do
      assert_equal "on the 1st Floor in the Babbio Center building in the Stevens Campus",
                   location(@s4)
    end

    should "generate an ancestors list with links" do
      assert_equal "#{link_to @s3.name, @s3}, #{link_to @s2.name, @s2}, #{link_to @s1.name, @s1}",
                   ancestors_list(@s4)
    end
  end

  should "generate 'in space' text for building" do
    space = ["Red", 'building']
    assert_equal "in the Red building", in_space_text(space[0],space[1])
  end

  should "generate 'in space' text for building that has Building in the name" do
    space = ["Red Building", 'building']
    assert_equal "in the Red Building", in_space_text(space[0],space[1])
  end
end
