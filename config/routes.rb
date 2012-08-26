Trackme::Application.routes.draw do

  root :to => "home#index"

  devise_for :users

  resources :locations
  # resources :sessions
  resources :events

  match 'events/add_follower' => 'events#add_follower'

end
