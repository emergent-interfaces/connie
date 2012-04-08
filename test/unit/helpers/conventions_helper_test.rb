require 'test_helper'

class ConventionsHelperTest < ActionView::TestCase
  context "with a default convention set" do
    setup do
      @con = FactoryGirl.create(:convention, :name => "Test Convention")
      session[:default_convention_id] = @con.id
    end

    should "return convention name" do
      assert_equal @con.name, default_convention_name
    end

    should "return convention" do
      assert_equal @con, default_convention
    end

    should "know a default convention is set" do
      assert default_convention_set?
    end

    should "filter models by session default" do
      @event = FactoryGirl.create(:event)
      @space = FactoryGirl.create(:space)
      assert_equal [@con, @event], session_filter(@event)
      assert_equal [@con, @space], session_filter(@space)
      assert_equal convention_events_path(@con), session_filter(events_path)
      assert_equal convention_spaces_path(@con), session_filter(spaces_path)
      assert_equal new_convention_space_path(@con), session_filter(new_space_path)
      assert_equal edit_convention_space_path(@con, @space), session_filter(edit_space_path(@space))
    end
  end

  context "with no default convention set" do
    setup do
      session[:default_convention_id] = nil
    end

    should "return 'All Conventions' as convention name" do
      assert_equal "All conventions", default_convention_name
    end

    should "return path to all conventions" do
      assert_equal conventions_path, default_convention
    end

    should "know a default convention is not set" do
      refute default_convention_set?
    end

    should "filter models by session default" do
      @event = FactoryGirl.create(:event)
      @space = FactoryGirl.create(:space)
      assert_equal @event, session_filter(@event)
      assert_equal @space, session_filter(@space)
      assert_equal events_path, session_filter(events_path)
      assert_equal spaces_path, session_filter(spaces_path)
      assert_equal new_space_path, session_filter(new_space_path)
      assert_equal edit_space_path(@space), session_filter(edit_space_path(@space))
    end
  end
end
