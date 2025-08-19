Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :teachers, shallow: true do
    resources :students
    resources :withdrawals, only: %i[new create]
  end

  resources :deposits, only: %i[new create]
  resources :classrooms

  get 'dashboard', to: 'pages#dashboard'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  root 'pages#dashboard'
end
