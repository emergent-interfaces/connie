require 'test_helper'

class ConventionTest < ActiveSupport::TestCase
  should validate_presence_of :name

  context "with a convention" do
    setup { FactoryGirl.create(:convention) } # required to validate_uniqueness

    should validate_uniqueness_of :name
  end

  should have_many(:linkables).through(:convention_linkables)
  should have_many :schedules

  should have_many :periods
  should have_many :auth_requirements

  should "create AuthRequirements at creation" do
    @convention = FactoryGirl.create(:convention)
    @convention.reload
    abilities = @convention.auth_requirements.collect{|ar| ar.action}
    actions = ["read", "manage"]
    assert_equal actions, abilities
  end

  context "with a convention and periods" do
    setup do
      @con = FactoryGirl.create(:convention)
      @p1 = FactoryGirl.create(:period, convention: @con, name: "Planning Stage 1")
      @p2 = FactoryGirl.create(:period, convention: @con, name: "Planning Stage 2")
      @p3 = FactoryGirl.create(:period, convention: @con, name: "Production")
      @p4 = FactoryGirl.create(:period, convention: @con, name: "Friday Open")
      @p5 = FactoryGirl.create(:period, convention: @con, name: "Open Hours Saturday")
      @p6 = FactoryGirl.create(:period, convention: @con, name: "Wrap-up")
    end

    should "identify all periods" do
      assert_equal [@p1, @p2, @p3, @p4, @p5, @p6], @con.periods
    end

    should "identify planning periods" do
      assert_equal [@p1, @p2], @con.periods(:planning)
    end

    should "identify production periods" do
      assert_equal [@p3], @con.periods(:production)
    end

    should "identify open periods" do
      assert_equal [@p4, @p5], @con.periods(:open)
    end

    should "identify wrap-up periods" do
      assert_equal [@p6], @con.periods(:wrap_up)
    end
  end
end
