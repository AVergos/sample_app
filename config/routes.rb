SampleApp::Application.routes.draw do

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :microposts,    :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  match '/users/:id/activate/:token', :controller => 'users', :action => 'activate'
  match '/microposts/', :to => 'pages#home'
  match '/microposts/:id', :to => 'users#show'
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  
  match "posts/add_new_comment" => "microposts#add_new_comment", :as => "add_new_comment_to_posts", :via => [:post]

  root :to => 'pages#home'
end

