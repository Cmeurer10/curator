Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations" }
  #   devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }


  scope '/dashboard' do
    resources :courses, except: [:show] do
      resources :books, except: [:show]
      resources :enrollments, except: [:show]
      resources :curatorships, except: [:show]
    end
  end

  resources :books, only: [:show] do
    resources :conversations, only: [:update, :destroy, :create] do
      resources :posts, only: [:index, :update, :destroy, :create] do
        get '/upvote', to: 'posts#upvote'
        get '/flag', to: 'posts#flag'
        get '/refresh_part', to: 'posts#refresh_part', on: :collection
      end
    end
  end

  get '/dashboard', to: 'pages#dashboard'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
