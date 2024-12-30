# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts "Cleaning database..."
[ Purchase, Donor, CalendarDay, Calendar, CampaignParticipant,
 ChampionAssignment, Campaign, OrganizationUser, Organization, User ].each(&:delete_all)

# Create an organization
puts "Creating organization..."
organization = Organization.create!(
  name: "Lincoln Elementary School",
  time_zone: "America/Chicago",
  settings: {}
)

# Create admin user
puts "Creating users..."
admin = User.create!(
  email: "admin@lincoln.edu",
  password: "password",
  first_name: "Admin",
  last_name: "User"
)

# Create champion user
champion = User.create!(
  email: "champion@lincoln.edu",
  password: "password",
  first_name: "Champion",
  last_name: "User"
)

# Create organization users
puts "Creating organization users..."
OrganizationUser.create!(
  organization: organization,
  user: admin,
  role: :admin
)

OrganizationUser.create!(
  organization: organization,
  user: champion,
  role: :champion
)

# Create a campaign
puts "Creating campaign..."
campaign = Campaign.create!(
  organization: organization,
  name: "Spring Fundraiser 2024",
  start_date: Date.today,
  end_date: 30.days.from_now,
  status: :active,
  settings: {}
)

# Create champion assignment
puts "Creating champion assignment..."
champion_assignment = ChampionAssignment.create!(
  campaign: campaign,
  user: champion
)

# Create campaign participants
puts "Creating campaign participants..."
3.times do |i|
  participant = CampaignParticipant.create!(
    campaign: campaign,
    champion_assignment: champion_assignment,
    first_name: "Student#{i+1}",
    last_name: "Test"
  )

  # Create calendar for each participant
  puts "Creating calendar for #{participant.first_name}..."
  calendar = Calendar.create!(
    campaign_participant: participant,
    number: 1
  )

  # Calendar days are automatically created via after_create callback
end

# Create some donors
puts "Creating donors..."
2.times do |i|
  Donor.create!(
    name: "Donor #{i+1}",
    email: "donor#{i+1}@example.com"
  )
end

puts "Seed data created successfully!"
puts "\nTest accounts:"
puts "Admin - Email: admin@lincoln.edu, Password: password"
puts "Champion - Email: champion@lincoln.edu, Password: password"
