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
    resources :campaigns do
      resources :champions
      resources :participants do
        collection do
          get :import
          post :process_import
        end
      end
    end
    collection do
      post :import_participants
    end
    resources :purchases
  end
  get "/dashboard", to: "organizations#show", as: :user_root

  # resources :registrations, only: [ :new, :create ]
  # resource :session
  # resources :passwords, param: :token

  root "pages#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
