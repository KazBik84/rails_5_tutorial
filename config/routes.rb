Rails.application.routes.draw do
  get 'users/new'

  get 'user/new'

  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  root 'static_pages#home'  
  get '/help'  , to: 'static_pages#help'
  get '/home', to: 'static_pages#home'

  get '/signup', to: 'users#new'

  resources :users

end
