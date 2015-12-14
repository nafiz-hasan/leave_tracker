Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'home#index'
end
