Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :cities, only: :index
      resources :restaurants, only: :index
      resources :meals, only: :index
      resources :orders, only: [:show, :create]
    end
  end

  scope 'api/v1' do
    devise_for :users, defaults: { format: :json }
  end
end
