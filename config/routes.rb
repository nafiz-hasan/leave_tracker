Rails.application.routes.draw do
  resources :holidays
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'home#index'
end
