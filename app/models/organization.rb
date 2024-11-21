class Organization < ApplicationRecord
  pay_merchant

  belongs_to :owner, class_name: "User"

  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :campaigns, dependent: :destroy
  has_many :purchases
  has_many :donors, through: :purchases
  has_one_attached :logo

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  before_create :set_subdomain

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

  def setup_stripe_connect_account
    return if merchant_processor.present?

    set_merchant_processor :stripe
    merchant_processor.create_account(
      type: "standard",
      capabilities: {
        card_payments: { requested: true },
        transfers: { requested: true }
      },
      business_type: "company",
      settings: {
        payouts: { schedule: { interval: "manual" } }
      }
    )
  end

  def stripe_connect_url
    return nil unless merchant_processor.present?

    merchant_processor.account_link(
      # refresh_url: Rails.application.routes.url_helpers.edit_organization_url(self, host: "#{subdomain}.#{ENV['APP_HOST']}"),
      # return_url: Rails.application.routes.url_helpers.organization_url(self, host: "#{subdomain}.#{ENV['APP_HOST']}")
      refresh_url: "http://localhost:3000/organizations/#{id}/stripe_connect",
      return_url: "http://localhost:3000/organizations/#{id}/"
    ).url
  end

  def stripe_dashboard_url
    return nil unless merchant_processor.present?

    merchant_processor.login_link.url
  end

  def stripe_account_ready?
    return false unless merchant_processor.present?

    begin
      account = merchant_processor.account
      account.charges_enabled && account.payouts_enabled
    rescue Stripe::PermissionError
      false
    end
  end
end
