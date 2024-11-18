class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def owner?
    user.owner?(ActsAsTenant.current_tenant)
  end

  def admin?
    user.admin?(ActsAsTenant.current_tenant)
  end

  def member?
    user.member?(ActsAsTenant.current_tenant)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    private

    attr_reader :user, :scope
  end
end
