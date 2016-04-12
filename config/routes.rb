Rails.application.routes.draw do
  root to: "cats#index"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:create, :new]
  resources :cats
  resources :cat_rental_requests, only: [:index, :create, :destroy, :update, :new, :edit, :show, :approve, :deny]
end
