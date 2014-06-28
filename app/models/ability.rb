class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

    can [:create, :upload], Customer if user.role?(:create_customers)
    can [:edit, :update], Customer if user.role?(:edit_customers)
    can :destroy, Customer if user.role?(:destroy_customers)

    can [:create, :upload], Contact if user.role?(:create_contacts)
    can [:edit, :update], Contact if user.role?(:edit_contacts)
    can :destroy, Contact if user.role?(:destroy_contacts)

    can [:create, :upload], Project if user.role?(:create_projects)
    can [:edit, :update], Project if user.role?(:edit_projects)
    can :destroy, Project if user.role?(:destroy_projects)

    can :manage, [User, Customer, Contact, Project, TimeLog], :client_id => user.client_id if user.client_admin?
  end
end
