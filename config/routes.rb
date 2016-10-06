# use resque to monitor Judge Job
# url: /resque
require 'resque/server'
Rails.application.routes.draw do

  # mount Resque::Server.new, :at => "/resque"
  mount ResqueWeb::Engine => "/resque" 

  # background
  namespace :admin do
    resources :managers
    resources :users
    resources :problems
    resources :ranks, only: :index
    resources :statuses, only: :index
    get 'login' => 'managers#login', as: :manager_login
    post 'create_login_session' => 'managers#create_login_session', as: :create_manager_login_session
    delete 'logout' => 'managers#logout', as: :manager_logout
  end

  # foreground
  resources :users, only: [:show, :edit, :update]
  resources :problems, only: :index
  resources :ranks, only: :index
  resources :statuses, only: :index
  resources :codes, only: [:new, :create]
  # get 'problems/:problem_id/judge' => 'codes#new', as: :new_code
  # post 'problems/:problem_id/judge' => 'codes#create', as: :codes
  # get 'problems' => 'problems#index', as: :problems
  get 'problems/:problem_id' => 'problems#show', as: :problem
  get 'login' => 'users#login', as: :login
  post 'create_login_session' => 'users#create_login_session', as: :create_login_session
  delete 'logout' => 'users#logout', as: :logout
  get 'home' => 'static_pages#home', as: :home
  get 'aboutus' => 'static_pages#aboutus', as: :aboutus
  post 'settheme' => 'static_pages#set_theme', as: :theme

  get 'user/:id/profile' => 'profiles#edit', as: :edit_profile

  # resource :profiles, only:[:update]
  post 'user/:id/profile' =>'profiles#update', as: :profile
  root 'static_pages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
