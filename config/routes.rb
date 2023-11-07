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
      resources :line_integration, only: %i[create]
      resources :authentications, only: %i[destroy], param: :provider
      post 'liff_sign_in', to: 'liff_sessions#create'
      post 'callback', to: 'line_bot#callback'
    end
  end

  get '*path', to: 'static_pages#top'
end
