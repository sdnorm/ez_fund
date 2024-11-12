Rails.application.routes.draw do
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  constraints(SubdomainRequired) do
    # Put all your organization-scoped routes here
    resources :users
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
  end

  # Routes without subdomain requirement
  constraints(SubdomainBlank) do
    resources :registrations, only: [ :new, :create ]
    resource :session
    resources :passwords, param: :token
    # public routes...
    root "pages#index"

    get "up" => "rails/health#show", as: :rails_health_check
  end
end
