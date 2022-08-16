Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :nutrients, only: %i[index show]
      resources :graph, only: %i[show]
      get 'graph/:id', to: 'graph#graph'
    end
  end

  get '*path', to: 'static_pages#top'
end
