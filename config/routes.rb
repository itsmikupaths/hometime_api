Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'health_check', to: 'health_check#index'
      resources :reservations, only: [:index, :create, :show]
    end
  end
end
