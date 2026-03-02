class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    elsif user.role.present?
      user.role.permissions.each do |perm|
        action = perm.action.to_sym
        resource = perm.resource.constantize rescue perm.resource.to_sym
        can action, resource
      end
    end
  end
end
