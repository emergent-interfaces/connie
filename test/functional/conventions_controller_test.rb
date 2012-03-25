require 'test_helper'

class ConventionsControllerTest < ActionController::TestCase

  context "with a TagGroup called 'Conventions'" do
    setup do
      Factory :tag_group, :name => "Conventions"
    end

    should "create a tag when created" do
      assert_difference('Tag.count') do
        post :create, :convention => {:name => "New Convention"}
      end

      tag = Tag.find_by_name("New Convention")
      assert_not_nil tag
      assert_equal TagGroup.find_by_name('Conventions'), tag.tag_group
    end

    should "rename its tag when renamed" do
      convention = Factory(:convention, :name => "New Convention")
      put :update, :id => convention.id, :convention => {:name => "Changed Name"}

      tag = Tag.find_by_group_and_tag_name("Conventions", "Changed Name")
      assert_equal "Changed Name", tag.name
    end

    should "not remove its tag when deleted" do
      convention = Factory(:convention, :name => "New Convention")
      delete :destroy, :id => convention.id

      assert_not_nil Tag.find_by_group_and_tag_name("Conventions", "New Convention")
    end
  end

end
