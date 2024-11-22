class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :campaigns, dependent: :destroy
  has_many :purchases
  has_many :donors, through: :purchases
  has_one_attached :logo

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  before_create :set_subdomain, :set_stripe_as_processor

  def set_subdomain
    self.subdomain = name.parameterize
  end

  def total_money_raised
    purchases.sum(:amount)
  end

  def donors_count
    donors.distinct.count
  end

  def recent_activities
    purchases.order(created_at: :desc).limit(10)
  end

  has_one_attached :logo

  def admins
    user_roles.where(role: %w[owner admin]).includes(:user).map(&:user)
  end

  def members
    users
  end

  pay_merchant

  def set_stripe_as_processor
    self.merchant_processor :stripe
  end

  def setup_stripe_connect_account
    return nil unless stripe_connect_enabled?
    
    account = Stripe::Account.create(
      type: "standard",
      country: "US",
      email: contact_email,
      capabilities: {
        card_payments: { requested: true },
        transfers: { requested: true }
      }
    )

    update(stripe_connect_account_id: account.id)

    account_links = Stripe::AccountLink.create(
      account: account.id,
      refresh_url: Rails.application.routes.url_helpers.stripe_connect_organization_url(self),
      return_url: Rails.application.routes.url_helpers.organization_url(self),
      type: "account_onboarding"
    )

    # Validate URL before returning
    return account_links.url if account_links.url&.start_with?("https://connect.stripe.com/")
    nil
  end

  def stripe_connect_url
    return nil unless stripe_connect_account_id

    account_link = Stripe::AccountLink.create({
      account: stripe_connect_account_id,
      refresh_url: Rails.application.routes.url_helpers.organization_url(self),
      return_url: Rails.application.routes.url_helpers.organization_url(self),
      type: "account_onboarding"
    })

    account_link.url
  end

  def stripe_dashboard_url
    return nil unless stripe_connect_account_id?

    link = Stripe::Account.create_login_link(stripe_connect_account_id)
    # Validate URL before returning
    return link.url if link.url&.start_with?("https://dashboard.stripe.com/")
    nil
  end

  def stripe_account_status
    return nil unless stripe_connect_account_id

    account = Stripe::Account.retrieve(stripe_connect_account_id)
    {
      charges_enabled: account.charges_enabled,
      details_submitted: account.details_submitted,
      payouts_enabled: account.payouts_enabled,
      requirements: account.requirements
    }
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Failed to retrieve Stripe account status: #{e.message}"
    nil
  end

  def stripe_account_complete?
    status = stripe_account_status
    status && status[:details_submitted] && status[:charges_enabled] && status[:payouts_enabled]
  end

  def stripe_account_requirements
    status = stripe_account_status
    return [] unless status && status[:requirements]

    status[:requirements][:currently_due] || []
  end

  private

  def stripe_connect_enabled?
    Stripe.api_key.present?
  end
end
