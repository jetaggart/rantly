Rails.application.routes.draw do
  root :to => "home#index"

  resources :users, :only => [:new, :create]
end
