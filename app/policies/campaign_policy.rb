class CampaignPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def show?
    member?
  end

  class Scope
    def resolve
      scope.all
    end
  end
end
