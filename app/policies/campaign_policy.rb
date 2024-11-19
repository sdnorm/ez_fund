class CampaignPolicy < ApplicationPolicy
  attr_reader :user, :record, :organization

  def initialize(user, record)
    @user = user
    @record = record
    @organization = record.is_a?(Class) ? Current.organization : record.organization
  end

  def create?
    admin_or_owner?
  end

  def edit?
    admin_or_owner?
  end

  def new?
    admin_or_owner?
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  def show?
    member?
  end

  private

  def admin_or_owner?
    user.admin?(@organization) || user.owner?(@organization)
  end

  def member?
    user.member?(@organization)
  end

  class Scope < Scope
    def resolve
      # All members can see campaigns for their organization
      scope.where(organization: user.organizations)
    end
  end
end
