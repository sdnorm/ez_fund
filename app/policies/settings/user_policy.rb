module Settings
  class UserPolicy < ApplicationPolicy
    def show?
      user == record
    end

    def update?
      show?
    end
  end
end
