class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?

    return unless user.profile

    user.permissions.each do |permission|
      can permission.action.to_sym,
          permission.model.constantize,
          :conventions => {:id => permission.convention_id}
    end

  end
end