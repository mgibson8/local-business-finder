Rails.application.routes.draw do
  root 'businesses#index'
  resources :businesses
  post 'businesses/list' , to: 'businesses#list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
