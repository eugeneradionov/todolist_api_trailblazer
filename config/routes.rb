Rails.application.routes.draw do
  apipie
  mount_devise_token_auth_for 'User', at: 'auth'

  root to: 'apipie/apipies#index'

  namespace :api, { defaults: { format: :json } } do
    namespace :v1 do
      resources :tasks, only: %i[show update destroy] do
        resources :comments, except: %i[show edit destroy]
      end
      patch 'tasks/:id/position', to: 'tasks#position'
      patch 'tasks/:id/complete', to: 'tasks#complete'

      resources :comments, only: %i[destroy]

      resources :projects, except: %i[edit] do
        resources :tasks, except: %i[edit show update destroy]
      end
    end
  end
end
