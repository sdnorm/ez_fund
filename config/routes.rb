Rails.application.routes.draw do
  # authenticated :user do
  #   # Protected routes
  #   resources :users
  #   resources :organizations do
  #     resources :campaigns do
  #       resources :champions
  #       resources :participants do
  #         collection do
  #           get :import
  #           post :process_import
  #         end
  #         member do
  #           get :download_qr_code
  #         end
  #       end
  #     end
  #     collection do
  #       post :import_participants
  #     end
  #     resources :purchases
  #   end
  #   root to: "organizations#index", as: :user_root
  # end

  # resources :users
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions",
    passwords: "user/passwords",
    confirmations: "user/confirmations",
    unlocks: "user/unlocks",
    omniauth_callbacks: "user/omniauth_callbacks"
  }
  resources :organizations do
    resources :champions
    resources :campaigns do
      resources :champions
      resources :participants do
        collection do
          get :import
          post :process_import
        end
        member do
          get :download_qr_code
        end
      end
    end
    collection do
      post :import_participants
    end
    resources :purchases
    member do
      post :stripe_connect
      get :stripe_dashboard
    end
  end
  get "calendar", to: "calendar#main", as: :calendar
  get "calendar/purchase", to: "calendar#detail", as: :calendar_detail
  get "/dashboard", to: "organizations#show", as: :user_root

  get "calendar/index", to: "calendar#index", as: :calendar_index
  post "calendar/select", to: "calendar#select", as: :select_calendar_day
  post "calendar/deselect", to: "calendar#deselect", as: :deselect_calendar_day

  mount MissionControl::Jobs::Engine, at: "/jobs"

  # resources :registrations, only: [ :new, :create ]
  # resource :session
  # resources :passwords, param: :token

  root "pages#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
