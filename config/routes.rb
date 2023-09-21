Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        omniauth_callbacks: 'api/v1/auth/omniauth_callbacks'
      }
      resources :nutrients, only: %i[index show]
      resources :dosages
      resources :user_graph, only: %i[index]
      resources :guest_user_graph, only: %i[create]
    end
  end

  get 'test', to: 'teset#index'
  post 'test', to: 'teset#create'
  get '*path', to: 'static_pages#top'
end
