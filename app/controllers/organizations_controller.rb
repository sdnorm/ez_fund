class OrganizationsController < ApplicationController
  layout "organization_setup", only: [ :new, :create ]
  # skip_before_action :require_organization, only: [ :new, :create ]

  before_action :authenticate_user!
  before_action :set_organization, only: %i[ edit update destroy ]

  # GET /organizations or /organizations.json
  def index
    if current_user.last_organization_id.present?
      @organization = Organization.find(current_user.last_organization_id)
    else
      redirect_to new_organization_path, alert: "You must create an organization before accessing the dashboard."
    end
  end

  # GET /organizations/1 or /organizations/1.json
  def show
    @organization = Organization.find(params[:id])

    if current_user.last_organization_id != @organization.id
      current_user.update(last_organization_id: @organization.id)
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to new_organization_path, alert: "Organization not found."
  end

  # GET /organizations/new
  def new
    @current_user = current_user
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations or /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.owner = current_user
    @organization.subdomain = @organization.name.parameterize
    @organization.user_roles.build(user: current_user, role: :admin)

    puts "Organization: #{@organization.inspect}"
    if @organization.save
      current_user.update(last_organization_id: @organization.id)
      redirect_to user_root_path, notice: "Organization created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/1 or /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1 or /organizations/1.json
  def destroy
    @organization.destroy!

    respond_to do |format|
      format.html { redirect_to organizations_path, status: :see_other, notice: "Organization was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def stripe_connect
    @organization = Organization.find(params[:id])
    authorize @organization

    begin
      onboarding_url = @organization.setup_stripe_connect_account
      safe_stripe_redirect(
        onboarding_url,
        organization_path(@organization),
        "Invalid Stripe Connect URL received. Please try again."
      )
    rescue => e
      Rails.logger.error "Stripe Connect Error: #{e.message}"
      redirect_to organization_path(@organization),
                  alert: "There was an error connecting to Stripe. Please try again."
    end
  end

  def stripe_dashboard
    @organization = Organization.find(params[:id])
    authorize @organization

    if !@organization.stripe_connect_account_id?
      redirect_to organization_path(@organization),
                  alert: "Please connect your Stripe account first."
      return
    end

    begin
      dashboard_url = @organization.stripe_dashboard_url
      safe_stripe_redirect(
        dashboard_url,
        organization_path(@organization),
        "Invalid Stripe dashboard URL received. Please ensure your Stripe account is properly set up."
      )
    rescue => e
      Rails.logger.error "Stripe Dashboard Error: #{e.message}"
      redirect_to organization_path(@organization),
                  alert: "Unable to access Stripe dashboard. Please try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :address_1, :address_2, :city, :state, :contact_email)
    end
end
