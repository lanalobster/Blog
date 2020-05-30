Rails.application.routes.draw do
  
  resources :articles
  resources :users
  resources :users, except: [:new]
  resources :articles do
    resources :comments
  end
  
  root 'pages#index'
  get 'welcome/index'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  # resources :users do
    post 'generate_username' => 'users#generate_username', constraint: OnlyAjaxRequest.new  
  # end
  
end
