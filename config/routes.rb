Rails.application.routes.draw do
  root 'folders#index'
  resources :folders, except: %i[show]

  resources :subfolders, only: %i[edit update destroy show]
  get ':parent_id/subfolders/index', to: 'subfolders#index', as: :index_subfolders
  get ':parent_id/subfolders/new', to: 'subfolders#new', as: :new_subfolders
  post ':parent_id/subfolders', to: 'subfolders#create'

  resources :upload_files, only: %i[new create destroy]
end
