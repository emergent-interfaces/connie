require 'test_helper'

class ConsControllerTest < ActionController::TestCase

  context "with a TagGroup called 'Cons'" do
    setup do
      Factory :tag_group, :name => "Cons"
    end

    should "create a tag when created" do
      assert_difference('Tag.count') do
        post :create, :con => {:name => "New Con"}
      end

      tag = Tag.find_by_name("New Con")
      assert_not_nil tag
      assert_equal TagGroup.find_by_name('Cons'), tag.tag_group
    end

    should "rename its tag when renamed" do
      con = Factory(:con, :name => "New Con")
      put :update, :id => con.id, :con => {:name => "Changed Name"}

      tag = Tag.find_by_group_and_tag_name("Cons", "Changed Name")
      assert_equal "Changed Name", tag.name
    end

    should "not remove its tag when deleted" do
      con = Factory(:con, :name => "New Con")
      delete :destroy, :id => con.id

      assert_not_nil Tag.find_by_group_and_tag_name("Cons", "New Con")
    end
  end

end
