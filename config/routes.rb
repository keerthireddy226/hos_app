Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication
  post '/login', to: 'auth#login'

  # Doctor routes
  resources :doctors, only: [] do
    member do
      get :appointments
      post :accept
      post :cancel
    end
  end

  # Patient routes
  resources :patients, only: [] do
    collection do
      get :hospitals
      get 'doctors/:hospital_id', action: :doctors
      post :book_appointment
    end
  end
end
