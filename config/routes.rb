PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # Named Routes
  get  '/register', to: 'users#new'         # Here, NOT below in resources
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'   # do need to post something here w/form_tag
  get  '/logout',   to: 'sessions#destroy'  # we can use a get here, because no need to delete anything

  # Resources
  resources   :categories, only:  [:new, :create, :show]
  resources   :posts,     except: [:destroy] do
    resources :comments,  only:   [:create, :index]
  end
  resources   :users, except: [:index, :destroy]
end
