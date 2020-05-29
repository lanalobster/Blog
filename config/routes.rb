Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :articles
  
  root 'pages#index'

  resources :articles do
    resources :comments
  end

  resources :users

  get 'about', to: 'pages#about'

  get 'signup', to: 'users#new'
  
  resources :users, except: [:new]
end
