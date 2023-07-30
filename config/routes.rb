Rails.application.routes.draw do
  devise_for :users
  root 'surveys#index'

  resources :surveys do
    resources :answers, only: %i[create show]
    post 'answer', to: 'surveys#answer'
    get 'fill_out', to: 'surveys#fill_out'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
