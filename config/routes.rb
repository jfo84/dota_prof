Rails.application.routes.draw do
  root 'teams#index'
  devise_for :users

  resources :teams, only: :index
  resources :players, only: [:show, :index]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :players, only: [:index, :destroy]
    resources :submissions, only: [:index, :destroy]
  end

  resources :players do
    resources :submissions, only: [:new, :create, :show, :destroy] do
      member do
        put "like", to: "submissions#vote"
      end
    end
  end

  resources :submissions, only: [:edit, :update]
  resources :thumbnails, only: [:new]
end
