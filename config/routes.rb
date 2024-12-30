Rails.application.routes.draw do
  draw :madmin
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root "home#index"

  resources :organizations, only: [ :new, :create ] do
    member do
      post :switch
    end
  end

  resource :dashboard, only: :show, controller: "dashboard"

  resources :calendar_days do
    member do
      post :select
      post :unselect
    end
  end

  namespace :settings do
    resource :profile, only: [ :show, :update ]
    resource :account, only: [ :show, :update ]
    resources :organizations, only: [ :index, :show, :edit, :update ] do
      resources :members, only: [ :index, :create, :destroy ]
      resources :invitations, only: [ :create, :destroy ]
    end
  end
end
