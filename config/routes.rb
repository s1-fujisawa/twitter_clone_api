Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
}

  get '/users/me', to: 'users#current_user_show'
  get '/users/search/:val', to: 'users#search'
  get '/users/tweets/:user_id', to: 'tweets#index_id'
  get '/users/:id/follows', to: 'users#getFollowUsers'
  get '/users/:id/followers', to: 'users#getFollower'
  get '/users/:id', to: 'users#other_user_show'
  
  get '/follow', to: 'follows#index'
  post '/follow', to: 'follows#create'
  delete '/follow/:id', to: 'follows#destroy'

  resources :tweets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
