Rails.application.routes.draw do
  get 'static_pages/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
end
