class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  # before_action :require_admin, only: [:edit, :update]
  # before_action :require_owner, only: [:destroy]

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  set_current_tenant_by_subdomain(:organization, :subdomain)

  # If you want to handle cases where the tenant is not found:
  rescue_from ActsAsTenant::Errors::NoTenantSet do
    redirect_to root_url(subdomain: false), alert: "Organization not found"
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def set_current_user
    @current_user = Current.user
  end
end
