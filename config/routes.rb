Rails.application.routes.draw do
  devise_for :users

  # Using high_voltage gem
  #root 'high_voltage/pages#show', id: 'home'
  root :to => "homes#show"

  get 'pages/home' => 'high_voltage/pages#show', id: 'home'

  resources :users, only: [:update]
  resources :paths do
    resources :lessons, except: [:index]
  end
end
