class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.admin?
    if user.client?
      can [:read, :update], User, id: user.id
      can :read, Project, id: user.projects.map(&:id)
      can :read, Client, id: user.projects.map(&:client_id)
      can :manage, ActiveAdmin::Page, name: "Dashboard"
    end
  end
end
