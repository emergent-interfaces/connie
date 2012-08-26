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

    context "with a Convention" do
      setup do
        @con = FactoryGirl.create(:convention)
      end

      should "require Event read to read event schedule" do
        @event = FactoryGirl.create(:event, :conventions => [@con])

        ability = Ability.new(@user)
        assert ability.cannot?(:read, @event.create_time_span)

        @con.auth_requirements.create(:action => "read",
                                      :model => "Event",
                                      :requirement => "*:*")
        @profile.roles.create(:department => "any", :name => "any", :convention => @con)
        ability = Ability.new(@user)
        assert ability.can?(:read, @event.create_time_span)
      end

      should "require Event update to modify event schedule" do
        @event = FactoryGirl.create(:event, :conventions => [@con])

        ability = Ability.new(@user)
        assert ability.cannot?(:create, @event.create_time_span)
        assert ability.cannot?(:update, @event.create_time_span)
        assert ability.cannot?(:destroy, @event.create_time_span)

        @con.auth_requirements.create(:action => "update",
                                      :model => "Event",
                                      :requirement => "*:*")
        @profile.roles.create(:department => "any", :name => "any", :convention => @con)
        ability = Ability.new(@user)
        assert ability.can?(:create, @event.create_time_span)
        assert ability.can?(:update, @event.create_time_span)
        assert ability.can?(:destroy, @event.create_time_span)
      end


      should "require Event read to read event reservations" do
        @event = FactoryGirl.create(:event, :conventions => [@con])

        ability = Ability.new(@user)
        assert ability.cannot?(:read, @event.reservations.create)

        @con.auth_requirements.create(:action => "read",
                                      :model => "Event",
                                      :requirement => "*:*")
        @profile.roles.create(:department => "any", :name => "any", :convention => @con)
        ability = Ability.new(@user)
        assert ability.can?(:read, @event.reservations.create)
      end

      should "require Event update to modify reservation" do
        @event = FactoryGirl.create(:event, :conventions => [@con])

        ability = Ability.new(@user)
        assert ability.cannot?(:create, @event.reservations.create)
        assert ability.cannot?(:update, @event.reservations.create)
        assert ability.cannot?(:destroy, @event.reservations.create)

        @con.auth_requirements.create(:action => "update",
                                      :model => "Event",
                                      :requirement => "*:*")
        @profile.roles.create(:department => "any", :name => "any", :convention => @con)
        ability = Ability.new(@user)
        assert ability.can?(:create, @event.reservations.create)
        assert ability.can?(:update, @event.reservations.create)
        assert ability.can?(:destroy, @event.reservations.create)
      end
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
