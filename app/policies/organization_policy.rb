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
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def switch?
    owner?
  end

  def create_account?
    user.present? && owner_or_admin?
  end

  def onboarding?
    user.present? && owner_or_admin?
  end

  private

  def member?
    record.users.include?(user)
  end

  def admin?
    record.organization_users.exists?(user: user, role: :admin)
  end

  def owner?
    record.owner == user
  end

  def owner_or_admin?
    owner? || admin?
  end
end
