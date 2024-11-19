class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def owner?
    tenant = ActsAsTenant.current_tenant
    Rails.logger.debug "Current tenant: #{tenant.inspect}"
    Rails.logger.debug "Current user: #{user.inspect}"
    Rails.logger.debug "Owner check: user.id (#{user.id}) == tenant.owner_id (#{tenant.try(:owner_id)})"
    return false if tenant.nil?
    user.id == tenant.try(:owner_id)
  end

  def admin?
    result = user.admin?(ActsAsTenant.current_tenant) || owner?
    Rails.logger.debug "Admin check result: #{result}"
    result
  end

  def member?
    result = user.member?(ActsAsTenant.current_tenant) || admin_or_owner?
    Rails.logger.debug "Member check result: #{result}"
    result
  end

  def admin_or_owner?
    result = admin? || owner?
    Rails.logger.debug "Admin or owner check result: #{result}"
    result
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
