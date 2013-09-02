class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    account_modify_authority
    account_rw_authority

    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :editor
      editor_can
    else
      guest_can
    end
  end

  def editor_can
    cannot [:edit_role, :update_role, :index], User

    can :rw, User
    can :modify, User do |user|
      user == @user
    end

    can :rw, Rate
    can :modify, Rate do |rate|
      rate.user == @user
    end

    can :rw, Notification
    can :modify, Notification do |notification|
      notification.sender == @user.id
    end

    can [:reply,:have_read], Notification do |notification|
      notification.receiver == @user.id
    end
  end

  def guest_can
     cannot :manage, :all
  end

  def account_modify_authority
    alias_action :edit, :update, :destroy, :to => :modify
  end

  def account_rw_authority
    alias_action :index, :show, :new, :create, :to => :rw
  end
end
