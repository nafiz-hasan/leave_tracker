Rails.application.routes.draw do
  resources :holidays do
    member do
      put :accept
      put :reject
      put :approve
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'home#index'

  #get '/ttf' => 'ttfpanels#index'

  resources :ttfpanels do
    get 'user_summary', on: :member
  end

end
