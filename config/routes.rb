Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'trips#index'
  get 'users/sign_up', to: 'users#new'
  resources :users, except:[:new]
  get '/trips/friends', to: 'trips#friends'
  resources :trips
  resources :friendships, except: [:index, :new, :edit, :update, :show]
  resources :events
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :images, only: [:new, :create, :show, :edit, :update, :destroy]


  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post 'events/:id', to: "events#copy", as: "copy_event"
  get '/events/images/new', to: 'images#new', as: "new_event_image"

  post 'trips/id/copy', to: "trips#copy", as: "copy_trip"
  get '/trips/images/new', to: 'images#new', as: "new_trip_image"
end
