class StripeConnectController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :authorize_organization, only: [ :create_account, :dashboard ]

  def create_account
    # Use Pay's merchant functionality with Standard account type
    @organization.set_merchant_processor(:stripe)

    begin
      if @organization.stripe_connect_id.present?
        # Retrieve existing account to check its status
        account = Stripe::Account.retrieve(@organization.stripe_connect_id)
        Rails.logger.info "Found existing Stripe account: #{account.id}"

        # If account exists but details_submitted is false, it means onboarding wasn't completed
        unless account.details_submitted
          Rails.logger.info "Account exists but onboarding incomplete. Creating new account link."
          return redirect_to_stripe_onboarding(account.id)
        end
      else
        # Create new Standard account
        Rails.logger.info "No existing Stripe account found. Creating new Standard account."
        account = Stripe::Account.create({
          type: "standard",
          country: "US",
          email: current_user.email,
          capabilities: {
            card_payments: { requested: true },
            transfers: { requested: true }
          }
        })

        # Save the Stripe Connect ID to our organization
        @organization.update!(stripe_connect_id: account.id)
        Rails.logger.info "Saved Stripe Connect ID: #{account.id} to organization"
      end

      Rails.logger.info "Creating account link for account: #{account.id}"
      redirect_to_stripe_onboarding(account.id)
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe error: #{e.message}"
      redirect_to edit_settings_organization_path(@organization), alert: "Failed to connect Stripe account: #{e.message}"
    end
  end

  def dashboard
    begin
      # Verify we have a valid Stripe account before redirecting
      if @organization.stripe_connect_id.blank?
        raise Stripe::StripeError.new("No Stripe account connected")
      end

      # For Standard connected accounts, redirect to their specific dashboard
      redirect_to "https://dashboard.stripe.com/#{@organization.stripe_connect_id}",
                 allow_other_host: true,
                 status: :see_other
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe error: #{e.message}"
      redirect_to edit_settings_organization_path(@organization),
                  alert: "Failed to access Stripe dashboard: #{e.message}"
    end
  end

  private

  def redirect_to_stripe_onboarding(account_id)
    account_link = Stripe::AccountLink.create({
      account: account_id,
      refresh_url: stripe_connect_onboarding_url,
      return_url: edit_settings_organization_url(@organization),
      type: "account_onboarding",
      collect: "eventually_due"
    })

    Rails.logger.info "Created account link. Redirecting to: #{account_link.url}"

    # Use redirect_to with status: 303 to ensure proper redirect handling
    redirect_to account_link.url, allow_other_host: true, status: :see_other
  end

  def set_organization
    @organization = current_user.current_organization
  end

  def authorize_organization
    authorize @organization, :create_account?
  end
end
