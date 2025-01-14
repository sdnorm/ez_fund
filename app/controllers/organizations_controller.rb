class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @organization = Organization.new(organization_params)
    @organization.owner = current_user

    if @organization.save
      @organization.organization_users.create(user: current_user, role: :admin)
      redirect_to @organization, notice: "Organization created successfully."
    else
      render :new
    end
  end

  def switch
    organization = Organization.find(params[:id])
    authorize organization, :switch?

    if current_user.switch_organization(organization)
      redirect_back_or_to dashboard_path, notice: "Switched to #{organization.name}"
    else
      redirect_back_or_to dashboard_path, alert: "Could not switch organizations"
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :slug)
  end
end
