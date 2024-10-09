Rails.application.routes.draw do
  root "events#index"

  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users
  resources :events

  # API endpoints
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events, only: [:index, :create, :show, :destroy]
    end
  end

end
