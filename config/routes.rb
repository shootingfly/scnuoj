Rails.application.routes.draw do

  mount RuCaptcha::Engine => "/rucaptcha"
  
  # Admin
  namespace :admin do
    # Admin::Managers
    get 'managers' => 'managers#index', as: :managers
    post 'managers' => 'managers#create'
    get 'managers/new' => 'managers#new', as: :new_manager
    get 'managers/:id/edit' => 'managers#edit', as: :edit_manager
    get 'managers/:id' => 'managers#show', as: :manager
    patch 'managers/:id' => 'managers#update'
    delete 'managers/:id' => 'managers#destroy'
    # Admin::Users
    get 'users' => 'users#index', as: :users
    post 'users' => 'users#create'
    get 'users/new' => 'users#new', as: :new_user
    get 'users/:student_id/edit' => 'users#edit', as: :edit_user
    get 'users/:student_id' => 'users#show', as: :user
    patch 'users/:student_id' => 'users#update'
    delete 'users/:student_id' => 'users#destroy'
    # Admin::Problems
    get 'problems' => 'problems#index', as: :problems
    post 'problems' => 'problems#create'
    get 'problems/new' => 'problems#new', as: :new_problem
    get 'problems/:problem_id/edit' => 'problems#edit', as: :edit_problem
    get 'problems/:problem_id' => 'problems#show', as: :problem
    patch 'problems/:problem_id' => 'problems#update'
    delete 'problems/:problem_id' => 'problems#destroy'
    # Admin::Ranks
    get 'rank' => 'ranks#index', as: :ranks
    # Admin::Statuses
    get 'status' => 'statuses#index', as: :statuses
    # Admin::Main
    get 'login' => 'main#login', as: :login
    post 'login' => 'main#login_session', as: :login_session
    delete 'logout' => 'main#logout', as: :logout
    get 'aboutus' => 'main#aboutus', as: :aboutus
    get 'home' => 'main#home', as: :home
    root 'main#login'
  end

  # OJ
  get 'problems' => 'problems#index', as: :problems
  get 'problems/:problem_id' => 'problems#show', as: :problem
  get 'problems/:problem_id/judge' => 'codes#new', as: :new_code
  post 'problems/:problem_id/judge' => 'codes#create', as: :codes
  get 'rank' => 'ranks#index', as: :ranks
  get 'status' => 'statuses#index', as: :statuses
  get 'users/:student_id' => 'users#show', as: :user
  get 'info' => 'users#edit', as: :edit_user
  get 'profile' => 'profiles#edit', as: :edit_profile
  post 'profile' => 'profiles#update', as: :profile
  put 'set_theme' => 'profiles#update_theme'
  get 'login' => 'main#login', as: :login
  post 'login' => 'main#login_session', as: :login_session
  delete 'logout' => 'main#logout', as: :logout
  get 'aboutus' => 'main#aboutus', as: :aboutus
  root 'main#home'

end
