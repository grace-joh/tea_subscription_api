Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      post '/subscriptions', to: 'customer_tea_subscriptions#create'
      patch '/subscriptions', to: 'customer_tea_subscriptions#update'
      get 'customers/:id/subscriptions', to: 'customers/subscriptions#index'
    end
  end
end
