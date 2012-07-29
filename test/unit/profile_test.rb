require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should have_many :conventions
  should have_many :phones
  should have_many :roles

  should have_one :user

  should "be able to create a profile" do
    assert_difference('Profile.count') do
      Profile.create(:name => 'Tanabe Ai')
    end
  end

  should "make array of departments" do
    profile = FactoryGirl.create(:profile)
    role1 = FactoryGirl.create(:role, :profile => profile, :department => "Dept A")
    role2 = FactoryGirl.create(:role, :profile => profile, :department => "Dept A")
    role3 = FactoryGirl.create(:role, :profile => profile, :department => "Dept B")
    assert_equal ["Dept A", "Dept B"], profile.departments
  end
end
