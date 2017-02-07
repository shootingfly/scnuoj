Rails.application.routes.draw do

    mount RuCaptcha::Engine => "/rucaptcha"
    namespace :admin do
        root 'main#login'
        get 'login' => 'main#login'
        post 'login' => 'main#login_session'
        delete 'logout' => 'main#logout'
        get 'about' => 'main#about'
        get 'home' => 'main#home'
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
    resources :comments, only: :create
    resources :ranks, only: :index do
        get 'week' => 'ranks#week', on: :collection
    end
    resources :statuses, only: :index do
        get 'error' => 'statuses#error', on: :member
    end
    resources :contests, only: [:index, :show] do
        member do
            get 'detail' => 'contests#detail'
            get 'problems' => 'contests#problems'
            # get 'problems/:problem_id' => 'contest_problems#show', as: :problem
            # get 'problems/:problem_id/judge' => 'contest_problems#judge', as: :judge
            # post 'problems/:problem_id/judge' => 'contest_problems#judge_job', as: :judge_job
            get 'status' => 'contests#status'
            get 'ranks' => 'contests#ranks'
        end
        resources :contest_problems, only: :show, path: "problems", as: "problems" do
            member do 
                get 'judge' => 'contest_problems#judge'
                post 'judge' => 'contest_problems#judge_job'
            end
        end
    end
    resources :users, only: :show do
        get 'solutions/:problem_id' => 'users#solution', as: :solution, on: :member
    end
    get 'password' => 'users#password'
    patch 'password' => 'users#password_post'
    get 'info' => 'users#edit'
    patch 'info' => 'users#update'
    get 'profile' => 'profiles#edit'
    post 'profile' => 'profiles#update'
    post 'set_theme' => 'main#set_theme'
    post 'set_mode' => 'main#set_mode'
    post 'set_locale' => 'main#set_locale'
    get 'login' => 'main#login'
    post 'login' => 'main#login_post'
    get 'register' => 'main#register'
    post 'register' =>'main#register_post'
    delete 'logout' => 'main#logout'
    get 'about' => 'main#about'
    get 'faq' => 'main#faq'
    get 'joinus' => 'main#joinus'
    root 'main#home'
end
