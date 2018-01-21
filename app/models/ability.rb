class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      if user.admin?
        admin_abilities
      else
        user.captain? ? captain_abilities : user_abilities
      end
    else
      guest_abilities
    end
  end

  protected

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities      
  end

  def captain_abilities
    can :read, :all
    can :create, Player, team: user.team
  end

  def admin_abilities
    can :manage, :all
  end
end
