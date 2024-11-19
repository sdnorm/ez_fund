class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # include RequiresOrganization

  allow_browser versions: :modern

  set_current_tenant_through_filter
  before_action :set_tenant_from_organization

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  # def set_current_user
  #   @current_user = current_user
  # end

  private

  def set_tenant_from_organization
    if params[:organization_id].present?
      organization = Organization.find(params[:organization_id])
      set_current_tenant(organization)
    end
  end
end
