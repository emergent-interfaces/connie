class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    return unless user.profile

    user.permissions.each do |permission|
      can permission.action.to_sym,
          permission.model.constantize,
          :conventions => {:id => permission.convention_id}

      if permission.model.constantize == Event and permission.action.to_sym == :read
        can :read, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
      end

      if permission.model.constantize == Event and permission.action.to_sym == :update
        can :create, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
        can :update, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
        can :destroy, TimeSpan, :time_spanable => {:conventions => {:id => permission.convention_id}}
      end

      if permission.model.constantize == Event and permission.action.to_sym == :read
        can :read, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
      end

      if permission.model.constantize == Event and permission.action.to_sym == :update
        can :create, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
        can :update, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
        can :destroy, Reservation, :reservee => {:conventions => {:id => permission.convention_id}}
      end
    end

  end
end
