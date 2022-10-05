Rails.application.routes.draw do
  get 'homes/top'
  get '/' => 'homes#top'

  post 'comments/:post_id/create' => 'comments#create'
  post 'comments/:id/update' => 'comments#update'
  post 'comments/:id/destroy' =>'comments#destroy'
  get 'comments/:id/edit' => 'comments#edit'


  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'
  
  post 'posts/create' => 'posts#create'
  post 'posts/:id/destroy' => 'posts#destroy'
  post 'posts/:id/update' => 'posts#update'
  get 'posts/:id/edit' => 'posts#edit'
  get 'posts/new' => 'posts#new'
  get 'posts/index' => 'posts#index'
  get 'posts/limit' => 'posts#limitindex'
  get 'posts/:id' => 'posts#show'
  get 'posts/serch' => 'posts#serch'

  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post  'signup' => 'users#create'
  get 'signup' => 'users#new'

  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  get 'users/:id/likes' => 'users#likes'
  post 'users/:id/update' => 'users#update'
  post 'users/:id/delete' => 'users#delete'


  resources :users do
    resources :relationships, only:[:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

end
