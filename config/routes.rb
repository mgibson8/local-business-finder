Rails.application.routes.draw do
  root 'businesses#index'
  get 'businesses/list' , to: 'businesses#list'
  get 'businesses/download_csv', to: 'businesses#download_csv'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
