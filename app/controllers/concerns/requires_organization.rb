module RequiresOrganization
  extend ActiveSupport::Concern

  included do
    before_action :require_organization, unless: :organization_setup_controller?
  end

  private

  def require_organization
    return if @current_user&.organizations&.exists?

    redirect_to new_organization_path
  end

  def organization_setup_controller?
    is_a?(OrganizationsController) || is_a?(RegistrationsController)
  end
end
