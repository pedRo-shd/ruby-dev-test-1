Rails.application.routes.draw do
  root 'folders#index'
  resources :folders, except: %i[show]

  resources :subfolders, only: %i[edit update destroy show]

  get ':folder_id/subfolders/index', to: 'subfolders#index', as: :index_subfolders
  get ':folder_id/subfolders/new', to: 'subfolders#new', as: :new_subfolders
  post ':folder_id/subfolders', to: 'subfolders#create'
end
