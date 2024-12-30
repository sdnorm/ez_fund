class OrganizationsController < ApplicationController
  def switch
    organization = Organization.find(params[:id])
    authorize organization, :switch?

    if current_user.switch_organization(organization)
      redirect_back_or_to dashboard_path, notice: "Switched to #{organization.name}"
    else
      redirect_back_or_to dashboard_path, alert: "Could not switch organizations"
    end
  end
end
