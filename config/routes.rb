Kindling::Application.routes.draw do
  devise_for :users

  resources :users, :only => [:show] do 
    resources :items, :only => [:index, :show]
  end

  root :to => 'home#show'
end
