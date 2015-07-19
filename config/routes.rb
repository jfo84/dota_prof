Rails.application.routes.draw do
  root 'teams#index'
  devise_for :users

  resources :teams, only: :index
  resources :players, only: [:show, :index]

  # namespace :admin do
  #   resources :users, only: [:index, :destroy]
  #   resources :submissions, only: [:index, :destroy]
  # end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
