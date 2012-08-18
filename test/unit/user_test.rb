require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to :profile

  should "default to not admin" do
    @user = User.create
    refute @user.admin
  end

  context "with a User and Profile" do
    setup do
      @profile = FactoryGirl.create(:profile)
      @user = FactoryGirl.create(:user, :profile => @profile)
    end

    should "know permissions with a single convention" do
      @convention = FactoryGirl.create(:convention)
      @profile.roles.create(:department => "concert", :name => "staff", :convention => @convention)

      @ar1 = @convention.auth_requirements.create(:action => "clean",
                                                  :model => "windshield",
                                                  :requirement => "concert:staff")
      assert_equal [@ar1], @user.permissions

      @ar2 = @convention.auth_requirements.create(:action => "dump",
                                                  :model => "laundry",
                                                  :requirement => "*:*")
      assert_equal [@ar1, @ar2], @user.permissions

      @ar3 = @convention.auth_requirements.create(:action => "placate",
                                                  :model => "rioter",
                                                  :requirement => "executive board:czar")
      assert_equal [@ar1, @ar2], @user.permissions
    end

    should "know permissions with multiple conventions" do
      @con1 = FactoryGirl.create(:convention)
      @con2 = FactoryGirl.create(:convention)
      @profile.roles.create(:department => "concert", :name => "staff", :convention => @con1)
      @profile.roles.create(:department => "ops", :name => "mascot", :convention => @con2)

      @ar1 = @con1.auth_requirements.create(:action => "clean",
                                            :model => "windshield",
                                            :requirement => "concert:staff")
      @ar2 = @con1.auth_requirements.create(:action => "dump",
                                            :model => "laundry",
                                            :requirement => "*:*")
      @ar3 = @con1.auth_requirements.create(:action => "placate",
                                            :model => "rioter",
                                            :requirement => "executive board:czar")
      @ar4 = @con2.auth_requirements.create(:action => "lend",
                                            :model => "hand",
                                            :requirement => "ops:mascot")
      @ar5 = @con2.auth_requirements.create(:action => "lend",
                                            :model => "potato",
                                            :requirement => "ops:driver")
      assert_equal [@ar1, @ar2, @ar4], @user.permissions
    end
  end
end
