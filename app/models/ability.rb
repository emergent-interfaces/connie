class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    return unless user.profile

    user.permissions.each do |permission|
      can permission.action.to_sym,
          :all,
          :conventions => {:id => permission.convention_id}

      if permission.action.to_sym == :read
        can :read, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
        can :read, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
      end

      if permission.action.to_sym == :manage
        can :manage, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
        can :manage, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
      end
    end

  end
end
