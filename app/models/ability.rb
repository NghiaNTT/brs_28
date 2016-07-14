class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, Category
      can :manage, Review
      can :manage, Book
    elsif user.user?
      can :read, :all
      can :manage, Review, user_id: user.id
      can :manage, BookRequest
    else
      can :read, :all
    end
  end
end
