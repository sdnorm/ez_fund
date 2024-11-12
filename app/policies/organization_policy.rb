class OrganizationPolicy < ApplicationPolicy
  def update?
    admin?
  end

  def destroy?
    owner?
  end

  def manage_users?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?(scope)
        scope.all
      else
        scope.where(id: user.organization_ids)
      end
    end
  end
end
