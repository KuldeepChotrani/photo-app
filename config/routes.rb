require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  devise_for :users
   root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope controller: :static do
    get :pricing
    resources :pricings
  end
  namespace :purchase do
    resources :checkouts
  end
  get "success", to: "purchase/checkouts#success"
  resources :subscriptions
  resources :webhooks, only: :create
  resources :billings, only: :create
  resources :pricings
end
