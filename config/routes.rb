PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  # Named Routes
  get  '/register', to: 'users#new'         # Here, NOT below in resources
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'   # do need to post something here w/form_tag
  get  '/logout',   to: 'sessions#destroy'  # we can use a get here, because no need to delete anything
  get  '/pin',      to: 'sessions#pin'
  post '/pin',      to: 'sessions#pin'


  # Resources
  resources     :users,       except: [:index, :destroy]
  resources     :categories,    only:  [:new, :create, :show]
  resources     :posts,       except: [:destroy] do
    member do
      post      :vote   #/posts/id/vote
    end
    resources   :comments,      only:   [:create, :index] do #/posts/id/comments/id
      member do
        post :vote   #/posts/id/comments/id/vote
      end
    end
  end
end
