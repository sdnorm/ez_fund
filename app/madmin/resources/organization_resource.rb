class OrganizationResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :stripe_connect_id
  attribute :settings
  attribute :time_zone
  attribute :slug
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :owner
  attribute :organization_users
  attribute :users
  attribute :campaigns
  attribute :pay_merchants
  attribute :merchant_processor

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  # def self.display_name(record) = record.name

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end
