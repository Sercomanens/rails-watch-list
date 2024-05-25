Rails.application.routes.draw do
  root to: "lists#index"

  resources :lists, except: [:edit, :update] do
    resources :bookmarks, only: [:new, :create]
    get 'bookmarks/add_movie', to: 'bookmarks#add_movie', as: 'add_movie_to_bookmark'
    post 'bookmarks/create_movie', to: 'bookmarks#create_movie', as: 'create_movie_to_bookmark'
  end

  resources :bookmarks, only: :destroy
end
