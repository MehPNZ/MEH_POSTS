# frozen_string_literal: true

Rails.application.routes.draw do
  resource :sessions, only: %i[new create destroy]

  resources :users

  resource :logs, only: %i[show]

  resources :posts do
    resources :comments, except: %i[new show]
  end

  namespace :admin do
    resources :users, only: %i[index create]
  end

  root 'posts#index'
end
