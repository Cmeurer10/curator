Rails.application.routes.draw do
  get 'enrollments/index'

  get 'enrollments/new'

  get 'enrollments/create'

  get 'enrollments/destroy'

  get 'curatorships/index'

  get 'curatorships/new'

  get 'curatorships/create'

  get 'curatorships/destroy'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '/dashboard' do
    resources :courses, except: [:show] do
      resources :books, except: [:show]
    end
  end

  resources :books, only: [:show] do
    resources :conversations, only: [:update, :destroy, :create] do
      resources :posts, only: [:index, :update, :destroy, :create]
    end
  end

  get '/dashboard', to: 'pages#dashboard'

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
