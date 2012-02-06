Trackme::Application.routes.draw do

  root :to => "home#index"

  devise_for :users
  resources :users

  resources :locations
  resources :sessions

end
