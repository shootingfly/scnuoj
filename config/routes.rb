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
        resources :users do
            collection do 
                get 'batch_new' => 'users#batch_new'
                post 'batch_new' => 'users#batch_create'
            end
        end
        resources :problems do
            member do 
                get 'chinesization' => 'problems#chinesization'
                post 'chinesization' => 'problems#chinesizations'
            end
        end
        resources :ranks, only: :index
        resources :statuses, only: :index
        resources :contests do
            resources :contest_problems, as: :problems, path: 'problems'
        end
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
            get 'problem' => 'contests#problem'
            get 'problem/:id' => 'contest_problem#show'
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
    resources :users, only: :show do
        get 'solutions/:problem_id' => 'users#solution', as: :solution, on: :member
    end
    get 'password' => 'users#edit_password'
    patch 'password' => 'users#update_password'
    get 'info' => 'users#edit'
    patch 'info' => 'users#update'
    get 'profile' => 'profiles#edit'
    post 'profile' => 'profiles#update'
    post 'set_theme' => 'main#set_theme', as: :set_theme
    post 'set_mode' => 'main#set_mode', as: :set_mode
    post 'set_locale' => 'main#set_locale', as: :set_locale
    get 'login' => 'main#login', as: :login
    post 'login' => 'main#login_session', as: :login_session
    delete 'logout' => 'main#logout', as: :logout
    get 'about-us' => 'main#about', as: :about
end
