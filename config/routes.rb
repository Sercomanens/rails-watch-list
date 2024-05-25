Rails.application.routes.draw do
  root to: 'lists#index'

  resources :lists, except: [:edit, :update] do
    resources :bookmarks, only: [:new, :create] do
      collection do
        get 'add_movie', to: 'bookmarks#add_movie'
        post 'create_movie', to: 'bookmarks#create_movie'
      end
    end
  end

  resources :bookmarks, only: :destroy
end
