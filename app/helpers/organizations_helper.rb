module OrganizationsHelper
  def stripe_account_status(organization)
    return :not_connected unless organization.stripe_connect_id.present?

    begin
      account = Stripe::Account.retrieve(organization.stripe_connect_id)
      return :incomplete unless account.details_submitted
      return :active if account.charges_enabled && account.payouts_enabled
      :incomplete
    rescue Stripe::StripeError => e
      Rails.logger.error "Error checking Stripe account status: #{e.message}"
      :error
    end
  end
end
