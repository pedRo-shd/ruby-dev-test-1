Rails.application.routes.draw do
  resources :folders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'folders#index'
end
