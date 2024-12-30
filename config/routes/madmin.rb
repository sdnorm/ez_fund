# Below are the routes for madmin
namespace :madmin do
  resources :calendars
  resources :calendar_days
  resources :campaigns
  resources :campaign_participants
  resources :champion_assignments
  resources :donors
  resources :organizations
  resources :organization_users
  resources :purchases
  resources :users

  root to: "dashboard#show"
end
