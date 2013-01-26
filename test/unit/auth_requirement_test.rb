require 'test_helper'

class AuthRequirementTest < ActiveSupport::TestCase
  should belong_to :convention
  should validate_presence_of :convention
  should validate_presence_of :action

  context "with a convention" do
    setup do
      @con = FactoryGirl.create(:convention)
    end

    should "return empty array if no requirements" do
      @ar = @con.auth_requirements.create(:requirement=>"")
      assert_equal [], @ar.requirements

      @ar = @con.auth_requirements.create(:requirement=>nil)
      assert_equal [], @ar.requirements
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

    should "know if is met by a role" do
      @ar = @con.auth_requirements.create(:requirement=>"*:*, a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "concert", :name => "staff")
      assert @ar.met_by(@role)

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "head")
      assert @ar.met_by(@role)

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "staff")
      refute @ar.met_by(@role)

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:*")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "staff")
      assert @ar.met_by(@role)

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:staff")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "", :name => "staff")
      refute @ar.met_by(@role)
    end

    should "know if it is met by at least one in a group of roles" do
      @role_z = FactoryGirl.create(:role, :convention => @con, :department => "undead", :name => "shambler")

      @ar = @con.auth_requirements.create(:requirement=>"*:*, a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "concert", :name => "staff")
      assert @ar.met_by_any_of([@role_z,@role])

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "head")
      assert @ar.met_by_any_of([@role_z,@role])

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:head")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "staff")
      refute @ar.met_by_any_of([@role_z,@role])

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:*")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "a/v tech", :name => "staff")
      assert @ar.met_by_any_of([@role_z,@role])

      @ar = @con.auth_requirements.create(:requirement=>"a/v tech:staff")
      @role = FactoryGirl.create(:role, :convention => @con, :department => "", :name => "staff")
      refute @ar.met_by_any_of([@role_z,@role])
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
