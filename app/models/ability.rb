class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :read, Post
      can :create, Post
      can :create, Comment
      can :update, Post, author_id: user.id
      can :update, Comment, user_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
      can :index, Post
    end
  end
end
