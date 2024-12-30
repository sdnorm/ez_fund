class OrganizationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:organization_users).where(organization_users: { user_id: user.id })
    end
  end

  def show?
    member?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def switch?
    member?
  end

  private

  def member?
    record.users.include?(user)
  end

  def admin?
    record.organization_users.exists?(user: user, role: :admin)
  end
end
