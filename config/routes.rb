PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources   :categories
  resources   :posts,     except: [:destroy] do
    resources :comments,  only:   [:create, :index]
  end


end
