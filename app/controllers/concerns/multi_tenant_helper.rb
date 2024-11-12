module MultiTenantHelper
  def switch_tenant(organization)
    ActsAsTenant.current_tenant = organization
    yield
  ensure
    ActsAsTenant.current_tenant = nil
  end
end 