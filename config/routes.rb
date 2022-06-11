Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  namespace :api do
    namespace :v1 do
      resources :nutrients, only: %i[index show]
      resources :graph, only: %i[show]
    end
  end

  get '*path', to: 'static_pages#top'
end
