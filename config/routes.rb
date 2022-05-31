# frozen_string_literal: true

Rails.application.routes.draw do
  resource :sessions, only: %i[new create destroy]

  resources :users

  resource :logs, only: %i[show]

  resources :posts do
    resources :logs, only: %i[new]
    resources :comments
  end

  resources :comments do
    resources :logs, only: %i[new]
  end

  root 'posts#index'
end
