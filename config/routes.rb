Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      resources :nutrients, only: %i[index show]
      resources :dosages
      get 'graph/nutrient/:nutrient_id', to: 'graph#draw24'
      get 'graph/me', to: 'graph#show'
    end
  end

  get '*path', to: 'static_pages#top'
end
