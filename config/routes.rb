Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'forecasts#new'
  get 'welcome/index'
  resources :codes
  resources :forecasts
end
