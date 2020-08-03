Rails.application.routes.draw do
  get 'users/new'
  get 'users/edit'
  get 'users/show'
  get 'users/index'
  root to: 'posts#index'
  resources :posts 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
