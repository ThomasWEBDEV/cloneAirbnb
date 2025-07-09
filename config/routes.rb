Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Dashboard utilisateur
  get "dashboard", to: "dashboard#index"

  # Routes pour les jardins + recherche + réservations imbriquées
  resources :gardens do
    collection do
      get :search  # <-- ajout de la route search
    end
    resources :bookings, only: [:create]
  end

  # Route pour voir toutes les réservations d'un utilisateur
  resources :bookings, only: [:index, :show]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :notifications, only: [:index] do
    member do
      patch :mark_as_read
    end
  end

  resources :bookings do
    member do
      patch :confirm
    end
  end

  # Legal pages from the footer
  get '/confidentiality', to: 'pages#confidentiality'
  get '/terms', to: 'pages#terms'
  get '/sitemap', to: 'pages#sitemap'
  get '/how-it-works', to: 'pages#how_it_works'
  get '/about-us', to: 'pages#about_us'

end
