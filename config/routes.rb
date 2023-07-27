Rails.application.routes.draw do
  devise_for :users
  root 'surveys#index'

  get 'questions/partial_form/:id', to: 'questions#partial_form'
  get 'questions/partial_closed/:id', to: 'questions#partial_closed'
  get 'questions/partial_true_false/:id', to: 'questions#partial_true_false'
  resources :surveys

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

