Rails.application.routes.draw do
  resources :bookmarks, only: [:index, :new, :create, :destroy, :show, :edit, :update]
  resources :lists
  resources :movies
end
