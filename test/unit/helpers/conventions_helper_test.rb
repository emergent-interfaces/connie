# Note the helper stubs for the methods in ApplicationController.  There should be
# a better way to do this.

require 'test_helper'

class ConventionsHelperTest < ActionView::TestCase

  context "with a default convention set" do
    setup do
      @con = FactoryGirl.create(:convention, :name => "Test Convention")
      session[:default_convention_id] = @con.id

      # Helper stubs
      def default_convention; @con end
      def default_convention_set?; true end
    end

    should "return convention name" do
      assert_equal @con.name, default_convention_name
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

      # Helper stubs
      def default_convention; conventions_path end
      def default_convention_set?; false end
    end

    should "return 'All Conventions' as convention name" do
      assert_equal "All Conventions", default_convention_name
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
