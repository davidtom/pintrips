Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'trips#index'
  get 'users/sign_up', to: 'users#new'
  resources :users, except:[:new]
  resources :trips
  resources :friendships, except: [:index, :new, :edit, :update, :show]
  resources :events
  resources :comments, only: [:create, :update, :delete]


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
