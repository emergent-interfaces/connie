require 'test_helper'

class AuthRequirementTest < ActiveSupport::TestCase
  should belong_to :convention
  should validate_presence_of :convention
  should validate_presence_of :action
  should validate_presence_of :model

  context "with a convention" do
    setup do
      @con = FactoryGirl.create(:convention)
    end

    should "break up requirements" do
      @ar = @con.auth_requirements.create(:requirement=>"*:*, board:co-chair,a/v tech:head")
      reqs = [{:dept=>"*",:name=>"*"},{:dept=>"board",:name=>"co-chair"},{:dept=>"a/v tech",:name=>"head"}]
      assert_equal reqs, @ar.requirements
    end

    should "break up requirements and ignore incomplete requirements" do
      @ar = @con.auth_requirements.create(:requirement=>"*:*, catbert,a/v tech:head")
      reqs = [{:dept=>"*",:name=>"*"},{:dept=>"a/v tech",:name=>"head"}]
      assert_equal reqs, @ar.requirements
    end

    should "not allow editing action" do
      @ar = @con.auth_requirements.create(:action => "edit", :model => "space", :requirement=>"*:*")

      assert_raise ActiveRecord::ActiveRecordError do
        @ar.update_attribute(:action, "march")
      end

      @ar.reload
      assert_equal "edit", @ar.action
    end

    should "not allow editing model" do
      @ar = @con.auth_requirements.create(:action => "edit", :model => "space", :requirement=>"*:*")

      assert_raise ActiveRecord::ActiveRecordError do
        @ar.update_attribute(:model, "yt-1300")
      end

      @ar.reload
      assert_equal "space", @ar.model
    end
  end
end
