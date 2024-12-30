module Settings
  class OrganizationsController < BaseController
    before_action :set_organization, only: [:show, :edit, :update]
    after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index

    def index
      @organizations = policy_scope(Organization)
    end

    def show
      authorize @organization
    end

    def edit
      authorize @organization
    end

    def update
      authorize @organization

      if @organization.update(organization_params)
        redirect_to settings_organization_path(@organization), notice: "Organization updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :time_zone)
    end
  end
end 