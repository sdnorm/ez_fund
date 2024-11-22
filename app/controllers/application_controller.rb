class ApplicationController < ActionController::Base
  set_referral_cookie
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

  def safe_stripe_redirect(url, fallback_path, error_message = nil)
    if url.present? && (
      url.start_with?("https://connect.stripe.com/") ||
      url.start_with?("https://dashboard.stripe.com/")
    )
      redirect_to url, allow_other_host: true
    else
      redirect_to fallback_path, alert: error_message || "Invalid redirect URL"
    end
  end
end
