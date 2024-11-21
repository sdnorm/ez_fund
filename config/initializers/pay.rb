Pay.setup do |config|
  # Enable Stripe Connect
  config.enabled_processors = [ :stripe ]
  config.business_name = "Your Business Name"
end
