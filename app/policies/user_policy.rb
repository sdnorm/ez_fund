class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def update?
    user == record
  end
end
