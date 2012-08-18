require 'test_helper'

class AbilityTest < ActiveSupport::TestCase

  context "with a User and Profile" do
    setup do
      @profile = FactoryGirl.create(:profile)
      @user = FactoryGirl.create(:user, :profile => @profile)
    end

    should "load abilities from AuthRequirements" do
      @con1 = FactoryGirl.create(:convention)
      @con2 = FactoryGirl.create(:convention)
      @profile.roles.create(:department => "concert", :name => "staff", :convention => @con1)
      @con1.auth_requirements.create(:action => "clean",
                                           :model => "Event",
                                           :requirement => "concert:staff")

      ability = Ability.new(@user)
      @event1 = Event.new(:conventions => [@con1])
      assert ability.can?(:clean, @event1)

      ability = Ability.new(@user)
      @event2 = Event.new(:conventions => [@con2])
      assert ability.cannot?(:clean, @event2)
    end

    should "give do anything as admin" do
      @user.admin = true
      ability = Ability.new(@user)
      assert ability.can?(:do_anything, Event.new)
    end
  end

  context "with a Profile-less User" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "not have abilities" do
      ability = Ability.new(@user)
      assert ability.cannot?(:clean, Event.new)
    end

    should "give do anything as admin" do
      @user.admin = true
      ability = Ability.new(@user)
      assert ability.can?(:do_anything, Event.new)
    end
  end
end
