Rails.application.routes.draw do
  resources :lists do
    resources :bookmarks, only: [:new, :create, :destroy] do
      collection do
        get 'add_movie'
        post 'create_movie'
      end
    end
  end
  root to: 'lists#index'
end
