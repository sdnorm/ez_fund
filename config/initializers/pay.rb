Pay.setup do |config|
  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.enabled_processors = [ :stripe ]

  config.business = {
    name: "Your Business Name",
    address: {
      line1: "123 Business Street",
      city: "City",
      state: "State",
      country: "US",
      postal_code: "12345"
    },
    support_email: "support@yourdomain.com"
  }
end
