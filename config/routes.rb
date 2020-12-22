Rails.application.routes.draw do
  root 'folders#index'
  resources :folders, except: %i[show]
end
