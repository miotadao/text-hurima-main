Rails.application.routes.draw do
  get 'guides/guide'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  root to: 'posts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'guide', to: 'guides#guide'
  get 'term', to: 'guides#term'

  resources :posts do
    member do
      patch :buy
      patch :cancel
      patch :completed
    end
    collection do
      get :my_list
    end
    resources :talks
  end

  resources :users
end
