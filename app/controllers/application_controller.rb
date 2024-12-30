class ApplicationController < ActionController::Base
  include Pundit::Authorization

  set_current_tenant_through_filter
  before_action :set_organization_as_tenant
  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from ActsAsTenant::Errors::NoTenantSet, with: :handle_no_tenant

  private

  def set_organization_as_tenant
    return unless current_user

    if !current_user.current_organization && current_user.organizations.any?
      current_user.update(current_organization_id: current_user.organizations.first.id)
    end

    if current_user.current_organization
      set_current_tenant(current_user.current_organization)
    else
      redirect_to new_organization_path, notice: "Please create or join an organization to continue."
    end
  end

  def handle_no_tenant
    redirect_to root_path, alert: "Please select an organization to continue."
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def after_sign_in_path_for(resource)
    if resource.organizations.none?
      new_organization_path
    else
      stored_location_for(resource) || dashboard_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
