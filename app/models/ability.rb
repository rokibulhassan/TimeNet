class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

    can :create, Customer if user.role?(:create_customers)
    can :edit, Customer if user.role?(:edit_customers)
    can :destroy, Customer if user.role?(:destroy_customers)

    can :create, Contact if user.role?(:create_contacts)
    can :edit, Contact if user.role?(:edit_contacts)
    can :destroy, Contact if user.role?(:destroy_contacts)

    can :create, Project if user.role?(:create_projects)
    can :edit, Project if user.role?(:edit_projects)
    can :destroy, Project if user.role?(:destroy_projects)

    can :manage, User, :client_id => user.client_id if user.role?(:client_admin)

  end
end
