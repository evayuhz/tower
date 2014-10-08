class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # team
    can :create, Team
    can [:read, :update, :destroy], Team, leader_id: user.id 
    can :read, Team do |team|
      team.members.include? user
    end

    # project 
    can :create, Project do |project|
      team = project.team
      team.leader_id == user.id || team.admin_members.include?(user) ||
                                   team.member_members.include?(user)
    end

    can :read, Project do |project|
      project.author_id == user.id || project.members.include?(user)
    end

    can [:update, :destroy], Project do |project|
      team = project.team
      project.author_id == user.id || 
      (project.members.include?(user) && (team.admin_members.include?(user) || team.leader_id == user.id ))
    end

    # todo
    can [:read, :create, :update, :complete], Todo do |todo|
      project = todo.project
      project.author_id == user.id || project.members.include?(user)
    end

    can :destroy, Todo do |todo|
      project = todo.project
      team = project.team

      project.author_id == user.id || 
        (project.members.include?(user) && (team.admin_members.include?(user) || team.leader_id == user.id)) ||
        todo.author_id == user.id
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
