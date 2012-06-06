require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should have_many :conventions
  should have_many :phones

  should have_one :user

  should "be able to create a profile" do
    assert_difference('Profile.count') do
      Profile.create(:name => 'Tanabe Ai')
    end
  end
end
