Rails.application.routes.draw do

    root 'main#home'
    mount RuCaptcha::Engine => "/rucaptcha"
    namespace :admin do
        root 'main#login'
        get 'login' => 'main#login', as: :login
        post 'login' => 'main#login_session', as: :login_session
        delete 'logout' => 'main#logout', as: :logout
        get 'aboutus' => 'main#aboutus', as: :aboutus
        get 'home' => 'main#home', as: :home
        resources :managers, except: :show
        resources :users
        get 'batch_new' => 'users#batch_new', as: :batch_new_user
        post 'batch_new' => 'users#batch_create', as: :batch_create_user
        resources :problems
        resources :ranks, only: :index
        resources :statuses, only: :index
    end

    # OJ
    resources :problems, only: [:index, :show] do
        member do
            get 'comment' => 'problems#comment'
            get 'judge' => 'problems#judge'
            post 'judge' => 'problems#judge_job'
            get 'prev' => 'problems#prev'
            get 'rand' => 'problems#rand'
            get 'next' => 'problems#next'
        end
    end

    resources :comments, only: [:create]
    resources :ranks, only: :index
    get 'week_rank' => 'ranks#week_rank', as: :week_rank
    resources :statuses, only: :index
    get 'status/:run_id/errors' => 'statuses#error', as: :status_error
    resources :contests, only: :index do
        member do
            get 'problems' => 'contests#problems'
            get 'problems/:problem_id' => 'contests#problem'
            get 'status' => 'contests#status'
            get 'rank' => 'contests#rank'
        end
    end
    # get 'rank' => 'ranks#index', as: :ranks
    # get 'status' => 'statuses#index', as: :statuses
    # get 'problems' => 'problems#index', as: :problems
    # get 'problems/:problem_id' => 'problems#show', as: :problem
    # get 'problems/:problem_id/judge' => 'codes#new', as: :new_code
    # post 'problems/:problem_id/judge' => 'codes#create', as: :codes
    # get 'rank' => 'ranks#index', as: :ranks
    # get 'status' => 'statuses#index', as: :statuses
    get 'users/:student_id' => 'users#show', as: :user
    get 'users/:student_id/solutions/:problem_id' => 'users#solution', as: :user_solution
    get 'password' => 'users#edit_password', as: :edit_password
    patch 'password' => 'users#update_password', as: :update_password
    get 'info' => 'users#edit', as: :edit_user
    patch 'info' => 'users#update', as: :update_user
    get 'profile' => 'profiles#edit', as: :edit_profile
    post 'profile' => 'profiles#update', as: :profile
    post 'set_theme' => 'main#set_theme', as: :set_theme
    post 'set_locale' => 'main#set_locale', as: :set_locale
    get 'login' => 'main#login', as: :login
    post 'login' => 'main#login_session', as: :login_session
    delete 'logout' => 'main#logout', as: :logout
    get 'aboutus' => 'main#aboutus', as: :aboutus

end
