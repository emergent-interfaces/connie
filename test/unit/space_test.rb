require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should belong_to :parent

  should have_many :reservations
  should have_many :maps

  should have_db_column(:parent_id).of_type(:integer)
  should have_db_column(:lft).of_type(:integer)
  should have_db_column(:rgt).of_type(:integer)
  should have_db_column(:depth).of_type(:integer)

  should validate_presence_of :space_type
  should allow_value("building").for(:space_type)
  should allow_value("floor").for(:space_type)
  should allow_value("area").for(:space_type)
  should allow_value("room").for(:space_type)
  should_not allow_value("hurkburjurgur").for(:space_type)
  should_not allow_value("bajizzlestein").for(:space_type)

  should have_one :own_address

  should "build icalendar of reservations" do
    @space = FactoryGirl.create(:space)
    assert @space.respond_to? :icalendar
  end

  should "be able to have address" do
    @address = FactoryGirl.create(:address)
    @space = FactoryGirl.create(:space, :own_address => @address, :inherit_address => false)
    assert_equal @address, @space.address
  end

  should "be able to inherit address" do
    @address = FactoryGirl.create(:address)
    @parent = FactoryGirl.create(:space, :own_address => @address, :inherit_address => false)
    @space = FactoryGirl.create(:space, :inherit_address => true, :parent => @parent)
    puts @space.name
    assert_equal @address, @space.address
  end

  should "be able to inherit address through multiple parents" do
    @address = FactoryGirl.create(:address)
    @grandparent = FactoryGirl.create(:space, :own_address => @address, :inherit_address => false)
    @parent = FactoryGirl.create(:space, :inherit_address => true, :parent => @grandparent)
    @space = FactoryGirl.create(:space, :inherit_address => true, :parent => @parent)
    assert_equal @address, @space.address
  end

  should "inherit address by default" do
    @space = FactoryGirl.create(:space)
    assert @space.inherit_address?
  end
end
