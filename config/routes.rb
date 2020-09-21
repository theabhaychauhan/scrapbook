Rails.application.routes.draw do
  resources :members
  resources :friendships
  root :to => 'members#index'
  # get 'search',to: "members#search"
  get '/:id', to: "members#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
