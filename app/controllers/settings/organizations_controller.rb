module Settings
  class OrganizationsController < BaseController
    before_action :set_organization, only: [ :show, :edit, :update, :onboarding ]
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

    def onboarding
      @organization = current_user.current_organization
      authorize @organization
    end

    private

    def set_organization
      @organization = if params[:id].present?
        Organization.find(params[:id])
      else
        current_user.current_organization
      end
    end

    def organization_params
      params.require(:organization).permit(:name, :time_zone)
    end
  end
end
